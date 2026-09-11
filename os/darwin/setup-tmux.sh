#!/bin/bash
set -euo pipefail

if [ "$(uname -s)" != Darwin ]; then
  echo "The tmux LaunchAgent is only supported on macOS." >&2
  exit 1
fi
if [ "$EUID" -eq 0 ]; then
  echo "Run this script as your login user, without sudo." >&2
  exit 1
fi

tmux_binary="$(type -P tmux || true)"
if [ -z "$tmux_binary" ]; then
  echo "Install tmux first (brew install tmux), then run this script again." >&2
  exit 1
fi

script_dir="$(cd -- "$(dirname -- "$0")" && pwd -P)"
agent_label=local.tmux.default
agent_dir="$HOME/Library/LaunchAgents"
agent_file="$agent_dir/$agent_label.plist"
log_dir="$HOME/Library/Logs/tmux"
launchd_domain="gui/$(id -u)"
launchd_service="$launchd_domain/$agent_label"

temp_plist="$(mktemp "${TMPDIR:-/tmp}/tmux-launchagent.XXXXXX")"
trap 'rm -f "$temp_plist"' EXIT
cp "$script_dir/$agent_label.plist" "$temp_plist"

# plutil escapes paths correctly, including spaces and XML special characters.
plutil -replace Program -string "$tmux_binary" "$temp_plist"
plutil -replace EnvironmentVariables.HOME -string "$HOME" "$temp_plist"
plutil -replace EnvironmentVariables.PATH -string "$(dirname -- "$tmux_binary"):$PATH" "$temp_plist"
plutil -replace EnvironmentVariables.TMUX_TMPDIR -string "${TMUX_TMPDIR:-/tmp}" "$temp_plist"
plutil -replace WorkingDirectory -string "$HOME" "$temp_plist"
plutil -replace StandardErrorPath -string "$log_dir/server.log" "$temp_plist"
plutil -lint -s "$temp_plist"

mkdir -p "$agent_dir" "$log_dir"
install -m 600 "$temp_plist" "$agent_file"
echo "Installed $agent_file"
launchctl enable "$launchd_service"

# Never restart a loaded job: doing so would terminate its sessions.
if launchctl print "$launchd_service" >/dev/null 2>&1; then
  echo "The tmux LaunchAgent is already loaded; it was not restarted."
  echo "Changes to the LaunchAgent file will take effect at the next login."
  exit 0
fi

# -N prevents this check from accidentally starting a server inside the terminal.
# -L default also avoids inspecting a named server inherited through $TMUX.
if "$tmux_binary" -N -L default show-options -s >/dev/null 2>&1; then
  echo "An existing default tmux server is running outside this LaunchAgent."
  echo "It was left running. The LaunchAgent will start at the next login."
  echo "To start it sooner, finish those sessions and run this script again."
  exit 0
fi

launchctl bootstrap "$launchd_domain" "$agent_file"

# bootstrap returns before the server has necessarily finished starting.
for ((attempt = 0; attempt < 50; attempt++)); do
  if "$tmux_binary" -N -L default show-options -s >/dev/null 2>&1; then
    echo "The default tmux server is running under launchd and will start at login."
    echo "Run tmux to create a session; use tmux a to reconnect later."
    exit 0
  fi
  sleep 0.1
done

echo "The LaunchAgent was loaded, but the tmux server did not become ready." >&2
echo "Check $log_dir/server.log and: launchctl print $launchd_service" >&2
exit 1

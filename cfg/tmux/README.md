# tmux

Prefix: `Alt-b` (`M-b`). Config: `.tmux.conf`. Helpers: `pane-status-label`,
`mirror-prefix-meta`.

## macOS LaunchAgent

`os/darwin/setup.sh` optionally installs and starts the default tmux server as a
user LaunchAgent. Press Enter to skip. To run just that installation step:

```sh
bash os/darwin/setup-tmux.sh
```

The installer renders `os/darwin/local.tmux.default.plist` into
`~/Library/LaunchAgents/local.tmux.default.plist`, using the installed tmux
binary, current PATH, home directory, and `TMUX_TMPDIR` (or `/tmp`). Errors go to
`~/Library/Logs/tmux/server.log`.

launchd runs `tmux -D -L default` in its own application coalition. The server
starts empty at login and remains available without clients or sessions. Use
`tmux` to create sessions and `tmux a` to reconnect. Other `-L` / `-S` servers
are independent and are not managed by this LaunchAgent.

Re-running the installer preserves running sessions. If a default server already
exists outside launchd, installation succeeds but startup waits until the next
login; finish those sessions and re-run the script to activate it sooner. A loaded
LaunchAgent is never restarted by the installer; updates to its plist apply at
the next login.

tmux still uses its normal configuration-file lookup. If the server was started
before your dotfiles or TPM were installed, reload the config afterward with
`tmux source-file ~/.tmux.conf`. KeepAlive restarts an exited server, but does not
restore its sessions or running programs. Stopping the job terminates its sessions:

```sh
launchctl bootout "gui/$(id -u)/local.tmux.default"
```

Remove `~/Library/LaunchAgents/local.tmux.default.plist` as well to stop starting
the server at login.

## Prefix bindings

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | select pane |
| `H` `J` `K` `L` | resize pane (repeatable) |
| `\|` | split horizontal, cwd from current pane |
| `-` | split vertical, cwd from current pane |
| `=` | equalize pane sizes, keep layout |
| `c` | new window, cwd from current pane |
| `,` | rename window (sticky name in the status bar) |
| `.` | move window before a given index |
| `` ` `` | last window |
| `r` | reload `~/.tmux.conf` |
| `s` | tmux-jump |
| `Alt-1` … `Alt-7` | select layout |

Copy mode uses vi keys. `v` starts selection, `y` copies.

## No prefix

| Key | Action |
| --- | --- |
| `Shift-Up` / `Shift-Down` | toggle or move the status bar |
| `Alt-Left` / `Alt-Right` | swap window with neighbor |
| `Alt-1` … `Alt-9` | select window |
| `Alt-h` `j` `k` `l` | pane movement (passed through in Vim) |

## Clipboard

Copy mode `y` and Codex `/copy` go through `clip` (`pbcopy`). Restart the tmux
server after changing `Ms` / `terminal-features` (`tmux kill-server`).

## Plugins

Installed via TPM (`~/.tmux/plugins/tpm`). Press `prefix` + `I` once.

- tmux-sensible
- tmux-resurrect
- tmux-jump

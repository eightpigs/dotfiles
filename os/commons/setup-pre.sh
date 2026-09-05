#!/bin/bash

mkdir -p "$HOME/Workspace" "$HOME/Downloads" "$HOME/.config"

# Python
# -----------------------------------------------------------------------------
if [ -f /usr/bin/python3 ]; then
  if ! /usr/bin/python3 -m pip --version >/dev/null 2>&1; then
    curl -fsSL https://bootstrap.pypa.io/get-pip.py -o get-pip3.py
    /usr/bin/python3 get-pip3.py
    rm get-pip3.py
  fi
  /usr/bin/python3 -m pip install --upgrade pip
  /usr/bin/python3 -m pip install pynvim
fi

# Rust
# -----------------------------------------------------------------------------
if [ ! -f "$HOME/.cargo/env" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
# shellcheck disable=SC1091
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
cargo install stylua --features lua54
cargo install tree-sitter-cli

# SSH key for GitHub (optional)
# -----------------------------------------------------------------------------
if [ ! -f "$HOME/.ssh/github" ]; then
  email="$(git config --global user.email 2>/dev/null || true)"
  if [ -z "$email" ]; then
    echo "Set git user.email before generating a GitHub SSH key, or create one yourself."
  else
    ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/github"
    mkdir -p "$HOME/.ssh"
    if [ ! -f "$HOME/.ssh/config" ]; then
      cat > "$HOME/.ssh/config" <<EOF
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/github
  PreferredAuthentications publickey
EOF
    fi
    echo "Add this public key at https://github.com/settings/keys"
    cat "$HOME/.ssh/github.pub"
    read -r _
  fi
fi

# Node Version Manager
# -----------------------------------------------------------------------------
if ! command -v nvm >/dev/null 2>&1; then
  latest_tag="$(curl --silent https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r .tag_name)"
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${latest_tag}/install.sh" | bash
fi

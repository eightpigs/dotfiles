#!/bin/bash

# Packages
# -----------------------------------------------------------------------------
sudo apt install \
  gperf luajit luarocks libuv1-dev silversearcher-ag exuberant-ctags dnsutils \
  libluajit-5.1-dev libunibilium-dev libmsgpack-dev libtermkey-dev libvterm-dev \
  libutf8proc-dev wget curl git make cmake build-essential gettext ncat autojump \
  python3-dev python3-venv python3-pip python3-neovim zsh tmux htop \
  unzip clang jq fd-find podman buildah skopeo apt-transport-https gnupg2 libreadline-dev \
  bat fzf unrar vpnc libjansson-dev ripgrep imagemagick

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

mkdir -p "$HOME/.local/bin"
if command -v fdfind >/dev/null 2>&1 && [ ! -e "$HOME/.local/bin/fd" ]; then
  ln -s "$(which fdfind)" "$HOME/.local/bin/fd"
fi

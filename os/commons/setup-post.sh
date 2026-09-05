#!/bin/bash

# Neovim from source (optional)
# -----------------------------------------------------------------------------
reinstallNeovim='n'
if command -v nvim >/dev/null 2>&1; then
  read -r -p "Rebuild Neovim from source? (y/n): " reinstallNeovim
else
  read -r -p "Build Neovim from source? (y/n): " reinstallNeovim
fi

if [ "$reinstallNeovim" = 'y' ] || [ "$reinstallNeovim" = 'Y' ]; then
  mkdir -p "$HOME/Workspace/git/neovim"
  cd "$HOME/Workspace/git/neovim" || exit 1
  if [ ! -d .git ]; then
    git clone https://github.com/neovim/neovim.git .
  else
    git fetch && git pull --ff-only
  fi
  make clean distclean
  if [ "$(uname -s)" = "Darwin" ]; then
    CMAKE_BUILD_TYPE=Release make -j "$(sysctl -n hw.physicalcpu)"
  else
    CMAKE_BUILD_TYPE=Release make -j "$(nproc)"
  fi
  make CMAKE_INSTALL_PREFIX="$HOME/.local/nvim" install
fi

# tmux plugin manager
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

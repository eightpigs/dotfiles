#!/bin/bash

reinstallNeovim='y'
if command -v nvim -version &> /dev/null
then
  read -p "Reinstall Neovim? (y/n): " reinstallNeovim
fi

if [ $reinstallNeovim == 'y' ]; then
  if [ ! -d ~/Workspace/git/neovim ]; then
    mkdir -p ~/Workspace/git/neovim
  fi
  cd ~/Workspace/git/neovim
  if ! command -v git status &> /dev/null
  then
    git clone git@github.com:neovim/neovim .
  else
    git fetch
    git pull origin
  fi
  sed -i "s/CMAKE_BUILD_TYPE ?= .*/CMAKE_BUILD_TYPE ?= Release/g" Makefile
  make clean distclean
  if [ `uname -s` == "Darwin" ]; then
    proxylup && make -j $(sysctl -n hw.physicalcpu) && proxydown
  else
    proxylup && make -j $(nproc) && proxydown
  fi
  make CMAKE_INSTALL_PREFIX=$HOME/.local/nvim install
fi

# tmux
[ ! -d ~/.tmux/plugins ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# lua tools
which lua-format &> /dev/null || luarocks install --server=https://luarocks.org/dev luaformatter

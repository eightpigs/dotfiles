#!/bin/bash

set -x




# Base
# -----------------------------------------------------------------------------
if [ -d /Applications/Xcode-beta.app ]; then
  sudo xcode-select --switch /Applications/Xcode-beta.app
fi
sudo xcode-select --install &> /dev/null

sudo scutil --set HostName fighter.local

if [ $SHELL != '/bin/zsh' ]; then
  chsh -s /bin/zsh
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/Workspace/git ]; then
  mkdir -p ~/Workspace/git
fi




# Python
# -----------------------------------------------------------------------------
if ! command -v /usr/bin/python2 -m pip --version &> /dev/null
then
  curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip2.py
  /usr/bin/python2 get-pip2.py
  /usr/bin/python2 -m pip install pynvim
  rm get-pip2.py
fi

if ! command -v /usr/bin/python3 -m pip --version &> /dev/null
then
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip3.py
  /usr/bin/python3 get-pip3.py
  /usr/bin/python3 -m pip install pynvim
  rm get-pip3.py
fi




# Homebrew & Softwares
# -----------------------------------------------------------------------------
if ! command -v brew --version &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
fi

export HOMEBREW_NO_AUTO_UPDATE=1
brews=(ninja libtool automake cmake pkg-config boost gettext \
  curl fzf fd bat the_silver_searcher mitmproxy tmux autojump unrar mycli htop ctags)
casks=(smcfancontrol hammerspoon alacritty)
for soft in ${brews[@]}
do
  brew list $soft > /dev/null 2>&1 || brew install $soft
done
for soft in ${casks[@]}
do
  brew list --cask $soft > /dev/null 2>&1 || brew install --cask $soft
done

if [ ! -d ~/.hammerspoon ]; then
  it clone git@github.com:eightpigs/awesome-hammerspoon.git ~/.hammerspoon
fi

# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
infocmp -x tmux-256color || (curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz \
  && gunzip terminfo.src.gz \
  && /usr/bin/tic -xe alacritty-direct,tmux-256color terminfo.src \
  && rm -f terminfo.src.gz
)




# Emacs
# -----------------------------------------------------------------------------
reinstallEmacs='y'
if [ -d /Applications/Emacs.app ]; then
  read -p "Reinstall Emacs? (y/n): " reinstallEmacs
  if [ $reinstallEmacs == 'y' ]; then
    rm /Applications/Emacs.app
    brew uninstall emacs-plus@28
  fi
fi

if [ $reinstallEmacs == 'y' ]; then
  brew install emacs-plus@28 \
    --with-ctags \
    --with-dbus \
    --with-mailutils \
    --with-native-comp \
    --with-modern-black-dragon-icon
  ln -s /usr/local/opt/emacs-plus@28/Emacs.app /Applications
fi




# Neovim
# -----------------------------------------------------------------------------
reinstallNeovim='y'
if command -v nvim -version &> /dev/null
then
  read -p "Reinstall Neovim? (y/n): " reinstallNeovim
fi

if [ $reinstallEmacs == 'y' ]; then
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
  make clean distclean
  proxylup && make -j 8 && proxydown
  make CMAKE_INSTALL_PREFIX=$HOME/.local/nvim install
fi

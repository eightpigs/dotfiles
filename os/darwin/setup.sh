#!/bin/bash




# Base
# -----------------------------------------------------------------------------
if [ -d /Applications/Xcode-beta.app ]; then
  sudo xcode-select --switch /Applications/Xcode-beta.app
else
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -runFirstLaunch
fi

xcode-select -v > /dev/null 2>&1
if [ $? != 0 ]; then
  sudo xcode-select --install &> /dev/null
fi

custom_hostname="fighter-air.local"
if [ $(hostname) != $custom_hostname ]; then
  sudo scutil --set HostName $custom_hostname
fi

if ! grep -q $custom_hostname /etc/hosts ; then
  sudo sed -i '' "s/\(^127\.0\.0\.1.*localhost.*$\)/\1     $custom_hostname/g" /etc/hosts
  sudo sed -i '' "s/\(^::1.*localhost.*$\)/\1     $custom_hostname/g" /etc/hosts
fi

if [ -f /opt/homebrew/bin/brew ]; then
 HOMEBREW_HOME=/opt/homebrew/
 PATH=$PATH:$HOMEBREW_HOME/bin
 export HOMEBREW_HOME PATH
fi

# Softwares
# -----------------------------------------------------------------------------
if ! command -v brew --version &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
fi

refreshHomebrew='y'
read -p "Update Homebrew softwares? (y/n): " refreshHomebrew
if [ $refreshHomebrew == 'y' ]; then
  export HOMEBREW_NO_AUTO_UPDATE=1
  brews=(ninja libtool automake cmake pkg-config boost gettext wget telnet curl \
    fzf fd bat the_silver_searcher mitmproxy tmux autojump unar mycli htop ctags \
    glow tree luarocks zsh gpg2 jq ripgrep sevenzip sdcv pyenv
  )
  for soft in ${brews[@]}
  do
    brew list $soft > /dev/null 2>&1 || brew install $soft
  done

  casks=(hammerspoon alacritty squirrel neovide wez/wezterm/wezterm eloston-chromium)
  for soft in ${casks[@]}
  do
    brew list --cask $soft > /dev/null 2>&1 || brew install --cask $soft
  done
fi

# use zsh
if [ $SHELL != $(which zsh) ]; then
  chsh -s $(which zsh)
fi

if [ ! -d ~/.fzf.zsh ]; then
  $(brew --prefix)/opt/fzf/install
fi

if [ ! -d ~/.hammerspoon ]; then
  git clone git@github.com:eightpigs/awesome-hammerspoon.git ~/.hammerspoon
fi

# https://github.com/htop-dev/htop/issues/251
# https://github.com/mikepqr/dotfiles/commit/12f8446ceeb3124ea6078e4f69b3008d3809d87e
curl -O https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color /usr/bin/tic -x tmux-256color



# cocoapods
gem install cocoapods --user-install
gem which cocoapods
source ~/.zshrc
pod install




# Emacs
# -----------------------------------------------------------------------------
reinstallEmacs='y'
if [ -d /Applications/Emacs.app ]; then
  read -p "Reinstall Emacs? (y/n): " reinstallEmacs
  if [ $reinstallEmacs == 'y' ]; then
    rm /Applications/Emacs.app
    brew uninstall emacs-plus@29
  fi
fi

if [ $reinstallEmacs == 'y' ]; then
  brew tap d12frosted/emacs-plus
  brew install emacs-plus@29 \
    --with-ctags \
    --with-dbus \
    --with-mailutils \
    --with-native-comp \
    --with-modern-black-dragon-icon
  ln -s /usr/local/opt/emacs-plus@29/Emacs.app /Applications
fi

# TODO, only for macos
# pip3 install asitop

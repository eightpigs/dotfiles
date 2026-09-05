#!/bin/bash




# Base
# -----------------------------------------------------------------------------

defaults write -g ApplePressAndHoldEnabled -bool false

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

# Optional machine-local settings (gitignored). See local.sh.example.
if [ -f "$(dirname "$0")/local.sh" ]; then
  . "$(dirname "$0")/local.sh"
fi

if [ -n "${CUSTOM_HOSTNAME:-}" ]; then
  if [ "$(hostname)" != "$CUSTOM_HOSTNAME" ]; then
    sudo scutil --set HostName "$CUSTOM_HOSTNAME"
  fi
  if ! grep -q "$CUSTOM_HOSTNAME" /etc/hosts ; then
    sudo sed -i '' "s/\(^127\.0\.0\.1.*localhost.*$\)/\1     $CUSTOM_HOSTNAME/g" /etc/hosts
    sudo sed -i '' "s/\(^::1.*localhost.*$\)/\1     $CUSTOM_HOSTNAME/g" /etc/hosts
  fi
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

if [ -f /opt/homebrew/bin/brew ]; then
 HOMEBREW_HOME=/opt/homebrew/
 PATH=$PATH:$HOMEBREW_HOME/bin
 export HOMEBREW_HOME PATH
fi

refreshHomebrew='y'
read -p "Update Homebrew softwares? (y/n): " refreshHomebrew
if [ $refreshHomebrew == 'y' ]; then
  export HOMEBREW_NO_AUTO_UPDATE=1
  brews=(ninja libtool automake cmake pkg-config boost gettext wget telnet curl \
    fzf fd bat the_silver_searcher mitmproxy tmux autojump unar mycli htop ctags \
    glow tree luarocks zsh gpg2 jq ripgrep sevenzip sdcv pyenv neovim imagemagick cocoapods litecli macmon
  )
  for soft in ${brews[@]}
  do
    brew list $soft > /dev/null 2>&1 || brew install $soft
  done

  casks=(hammerspoon alacritty neovide wez/wezterm/wezterm eloston-chromium firefox@developer-edition zed visual-studio-code ollama)
  if [ -n "${extra_casks:-}" ]; then
    casks+=("${extra_casks[@]}")
  fi
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

if [ -n "${HAMMERSPOON_REPO:-}" ] && [ ! -d ~/.hammerspoon ]; then
  git clone "$HAMMERSPOON_REPO" ~/.hammerspoon
fi

# https://github.com/htop-dev/htop/issues/251
terminfo_src="$(dirname "$0")/../commons/tmux-256color"
if [ -f "$terminfo_src" ]; then
  /usr/bin/tic -x "$terminfo_src"
fi



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
    --with-dbus \
    --with-mailutils \
    --with-native-comp \
    --with-no-frame-refocus \
    --with-modern-black-dragon-icon
  emacs_app="$(brew --prefix emacs-plus@29 2>/dev/null)/Emacs.app"
  if [ -d "$emacs_app" ]; then
    ln -sfn "$emacs_app" /Applications/Emacs.app
  fi
fi

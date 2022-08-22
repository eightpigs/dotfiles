#!/bin/bash




# Base
# -----------------------------------------------------------------------------
if [ -d /Applications/Xcode-beta.app ]; then
  sudo xcode-select --switch /Applications/Xcode-beta.app
fi
sudo xcode-select --install &> /dev/null
sudo scutil --set HostName fighter.local




# Softwares
# -----------------------------------------------------------------------------
if ! command -v brew --version &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
fi

export HOMEBREW_NO_AUTO_UPDATE=1
brews=(ninja libtool automake cmake pkg-config boost gettext wget telnet curl \
  fzf fd bat the_silver_searcher mitmproxy tmux autojump unar mycli htop ctags \
  glow tree luarocks zsh gpg2 jq
)
casks=(hammerspoon alacritty squirrel)

brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

for soft in ${brews[@]}
do
  brew list $soft > /dev/null 2>&1 || brew install $soft
done
for soft in ${casks[@]}
do
  brew list --cask $soft > /dev/null 2>&1 || brew install --cask $soft
done

brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm

# use zsh
chsh -s $(which zsh)

if [ ! -d ~/.hammerspoon ]; then
  it clone git@github.com:eightpigs/awesome-hammerspoon.git ~/.hammerspoon
fi

# https://github.com/htop-dev/htop/issues/251
# https://github.com/mikepqr/dotfiles/commit/12f8446ceeb3124ea6078e4f69b3008d3809d87e
curl -O https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color /usr/bin/tic -x tmux-256color




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
  brew tap d12frosted/emacs-plus
  brew install emacs-plus@28 \
    --with-ctags \
    --with-dbus \
    --with-mailutils \
    --with-native-comp \
    --with-modern-black-dragon-icon
  ln -s /usr/local/opt/emacs-plus@28/Emacs.app /Applications
fi

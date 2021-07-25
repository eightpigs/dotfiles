#!/bin/bash

if [ $XDG_CONFIG_HOME == "" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

# OS Init.
$PWD/os/setup.sh

# Custom bin.
[ ! -d ~/.local/bin ] && mkdir ~/.local/bin
cp -rf $PWD/bin/* ~/.local/bin

# Configs
if [ -d $XDG_CONFIG_HOME ]; then
  mv $XDG_CONFIG_HOME $HOME/.config.bak-$(date '+%Y-%m-%d %H:%M:%S')
fi
mkdir $XDG_CONFIG_HOME

for cfg in `ls -a $PWD/cfg/`;
do
  if [ $cfg == "." ] || [ $cfg == ".." ]; then
    continue
  fi
  CFG_FILE="$PWD/cfg/$cfg/.init.sh"
  if [ -f $CFG_FILE ]; then
    chmod +x $CFG_FILE
    $CFG_FILE
  else
    ln -sfv $PWD/cfg/$cfg $XDG_CONFIG_HOME/$cfg
  fi
done

# Profiles
ln -sfv $PWD/profiles.d $XDG_CONFIG_HOME/profiles.d

if [ -f ~/.zshrc ]; then
  cat>~/.zshrc<<EOF
source ~/.config/profiles.d/main
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
EOF
else
  echo "~/.zshrc not found."
fi

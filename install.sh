#!/bin/bash

if [ $XDG_CONFIG_HOME == "" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

# OS Init.
$PWD/os/setup.sh

# Custom bin.
cp -rf $PWD/bin/* ~/.local/bin

if [ -d $XDG_CONFIG_HOME ]; then
  mv $XDG_CONFIG_HOME $HOME/.config.bak-$(date +%F)
fi
mkdir $XDG_CONFIG_HOME

# Configs
for cfg in `ls -a $PWD/cfg/`;
do
  if [ $cfg == "." ] || [ $cfg == ".." ]; then
    continue
  fi
  if [ -f "$PWD/cfg/$cfg/.init.sh" ]; then
    chmod +x $PWD/cfg/$cfg/.init.sh
    $PWD/cfg/$cfg/.init.sh
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

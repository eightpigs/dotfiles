#!/bin/bash

export XDG_CONFIG_HOME="$HOME/.config"


# OS Init.
# -----------------------------------------------------------------------------
$PWD/os/setup.sh


# Customized bin.
# -----------------------------------------------------------------------------
[ ! -d ~/.local/bin ] && mkdir ~/.local/bin
for f in `ls -a $PWD/bin/`;
do
  ln -s $PWD/bin/$f ~/.local/bin/$f > /dev/null 2>&1
done


# Configs
# ----------------------------------------------------------------------------

# backup
backup_file=$HOME/.config.bak-$(date '+%Y-%m-%d_%H:%M:%S')
if [ -d $XDG_CONFIG_HOME ]; then
  cp -r $XDG_CONFIG_HOME $backup_file
  echo "Backup dir: $backup_file"
fi

for cfg in `ls -a $PWD/cfg/`;
do
  if [ $cfg == "." ] || [ $cfg == ".." ]; then
    continue
  fi
  rm -rf $XDG_CONFIG_HOME/$cfg
  CFG_FILE="$PWD/cfg/$cfg/.init.sh"
  if [ -f $CFG_FILE ]; then
    chmod +x $CFG_FILE
    $CFG_FILE
  else
    ln -sfv $PWD/cfg/$cfg $XDG_CONFIG_HOME/$cfg > /dev/null 2>&1
  fi
done

# Profiles
# -----------------------------------------------------------------------------
rm -r $XDG_CONFIG_HOME/profiles.d
ln -sfv $PWD/profiles.d $XDG_CONFIG_HOME/profiles.d


if [ -f ~/.zshrc ]; then
  cat>~/.zshrc<<EOF
source ~/.config/profiles.d/main
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
EOF
else
  echo "~/.zshrc not found."
fi

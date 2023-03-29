#!/bin/bash

export XDG_CONFIG_HOME="$HOME/.config"
section_prefix="=> "

run_confirm() {
  read -p "$section_prefix$1? (y/n): " run_confirm_result
  if [[ $run_confirm_result == 'y' || $run_confirm_result == 'Y' ]]; then
    return 0
  else
    echo "   Skip $1."
    echo ""
    return 1
  fi
}

append_to_file() {
  if ! grep -q $1 $3 ; then
    echo $2 >> $3
  fi
}


# OS Init.
# -----------------------------------------------------------------------------
if run_confirm "Execute OS setup scripts"; then
  $PWD/os/setup.sh
fi


# Customized bin.
# -----------------------------------------------------------------------------
if run_confirm "Copy customized bins to ~/.local/bin"; then
  [ ! -d ~/.local/bin ] && mkdir ~/.local/bin
  for f in `ls -a $PWD/bin/`;
  do
    ln -s $PWD/bin/$f ~/.local/bin/$f > /dev/null 2>&1
  done
fi


# Configs
# ----------------------------------------------------------------------------

# backup
backup_file=$HOME/.config.bak-$(date '+%Y-%m-%d_%H:%M:%S')
if [ -d $XDG_CONFIG_HOME ]; then
  echo $section_prefix"Backuping..."
  find ~/.config -maxdepth 1 \
    -not -name 'nvm' \
    | grep -Ev "$HOME/.config$" \
    | xargs -I{} cp -r {} $backup_file/
  echo "   Backuped, dir: $backup_file"
  echo ""
fi

# copy cfgs to ~/.config
if run_confirm "Copy cfgs to ~/.config"; then
  for cfg in `find cfg/* -maxdepth 1 -type d -not -name '.' -not -name '..'`;
  do
    xdg_cfg=$XDG_CONFIG_HOME/$cfg
    rm -rf $xdg_cfg

    cfg_dir=$PWD/$cfg
    cfg_init="$cfg_dir/.init.sh"

    if [ -f $cfg_init ]; then
      chmod +x $cfg_init
      $cfg_init
    else
      ln -sfv $cfg_dir $xdg_cfg > /dev/null 2>&1
    fi
  done
fi

# Profiles
# -----------------------------------------------------------------------------
if run_confirm "Update profiles.d"; then
  rm -r $XDG_CONFIG_HOME/profiles.d
  ln -sfv $PWD/profiles.d $XDG_CONFIG_HOME/profiles.d
fi


if [ -f ~/.zshrc ]; then
  append_to_file "^source.*profiles.d/main$" "source ~/.config/profiles.d/main" ~/.zshrc
  append_to_file "source.*fzf.zsh$" "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" ~/.zshrc
else
  echo "~/.zshrc not found."
fi

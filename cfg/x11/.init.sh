#!/bin/bash

# x11, wayland, tty
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
  rm ~/.Xresources
  rm ~/.xinitrc
  ln -sfv $PWD/cfg/x11/Xresources ~/.Xresources
  ln -sfv $PWD/cfg/x11/xinitrc ~/.xinitrc
  xrdb -merge $HOME/.Xresources
fi



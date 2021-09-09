#!/bin/bash

if ! command -v polybar --version &> /dev/null
then
  rm -rf $XDG_CONFIG_HOME/polybar
  ln -s $PWD/cfg/polybar $XDG_CONFIG_HOME/polybar
fi

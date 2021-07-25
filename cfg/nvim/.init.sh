#!/bin/bash

# TODO open vide.git
[ ! -d $HOME/Workspace/git/vide ] && git clone git@github.com:eightpigs/vide.git
ln -svf $PWD/cfg/nvim $XDG_CONFIG_HOME/nvim
ln -svf $HOME/Workspace/git/vide $XDG_CONFIG_HOME/nvim/lua

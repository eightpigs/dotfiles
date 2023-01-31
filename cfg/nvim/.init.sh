#!/bin/bash

# TODO open vide.git
[ ! -d $HOME/Workspace/git/vide ] && git clone git@github.com:eightpigs/vide.git $HOME/Workspace/git/vide
rm -rf $XDG_CONFIG_HOME/nvim
ln $HOME/Workspace/git/vide -s $XDG_CONFIG_HOME/nvim

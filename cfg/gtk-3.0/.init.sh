#!/bin/bash
whereis gtk-config > /dev/null 2>&1 && \
  (rm -rf $HOME/.gtk-3.0 && ln -sfv $PWD/cfg/gtk-3.0 $HOME/.gtk-3.0)

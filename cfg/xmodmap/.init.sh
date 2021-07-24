#!/bin/bash
whereis xmodmap > /dev/null 2>&1 && \
  (rm -rf $HOME/.Xmodmap && ln -sfv $PWD/cfg/xmodmap $HOME/.Xmodmap)

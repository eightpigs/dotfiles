#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
OS=`uname -s | awk '{print tolower($0)}'`
OS_ARCH=`uname -m`
OS_DIR="$SCRIPTPATH/$OS/"
OS_FILE=$OS_DIR"setup.sh"

export OS
export OS_ARCH

if [ $OS == "linux" ]; then
  kernel_version=`uname -v | awk '{print tolower($0)}'`
  for distro_file in `ls $OS_DIR`;
  do
    distro=${distro_file//\.sh/}
    if echo "$kernel_version" | grep -q "$distro"
    then
      OS_FILE="$OS_DIR$distro_file"
      break
    fi
  done
fi

"$SCRIPTPATH/commons/setup-pre.sh"

if [ -f "$OS_FILE" ]; then
  $OS_FILE
fi

"$SCRIPTPATH/commons/setup-post.sh"

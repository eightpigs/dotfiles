#!/bin/bash

set -x



# Base
# -----------------------------------------------------------------------------
tz=`sudo timedatectl show -p Timezone | awk -F "=" '{print $2}'`
if [ $tz != "Asia/Shanghai" ]; then
  sudo timedatectl set-timezone Asia/Shanghai
fi
if [ `sudo sysctl -n kernel.unprivileged_userns_clone` != "1" ]; then
  sudo sysctl -w kernel.unprivileged_userns_clone=1
fi




# Softwares
# -----------------------------------------------------------------------------
sudo apt install gperf luajit luarocks libuv1-dev \
  libluajit-5.1-dev libunibilium-dev libmsgpack-dev \
  libtermkey-dev libvterm-dev libutf8proc-dev silversearcher-ag \
  wget curl git make cmake build-essential gettext python3-distutils \
  zsh tmux htop unzip clang python-dev python3-dev jq dnsutils podman buildah skopeo \
  apt-transport-https gnupg2 ncat autojump libreadline-dev bat


# TODO check to sid.

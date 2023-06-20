#!/bin/bash




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
sudo apt install \
  gperf luajit luarocks libuv1-dev silversearcher-ag exuberant-ctags dnsutils \
  libluajit-5.1-dev libunibilium-dev libmsgpack-dev libtermkey-dev libvterm-dev \
  libutf8proc-dev wget curl git make cmake build-essential gettext ncat autojump \
  python3-distutils python-dev python3-dev python3-venv python3-pip zsh tmux htop \
  unzip clang jq fd-find podman buildah skopeo apt-transport-https gnupg2 libreadline-dev \
  bat fzf unrar vpnc libjansson-dev zsh ripgrep

# use zsh
chsh -s /bin/zsh

# fdfind to fd
ln -s $(which fdfind) ~/.local/bin/fd

# TODO check to sid.

pip3 install mycli


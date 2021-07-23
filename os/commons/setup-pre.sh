#!/bin/bash

# Shell
if [ $SHELL != '/bin/zsh' ]; then
  chsh -s /bin/zsh
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi




# Dir
mkdir -p $HOME/{Workspace,Downloads,.config}



# Python
# -----------------------------------------------------------------------------
if ! command -v /usr/bin/python2 -m pip --version &> /dev/null
then
  curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip2.py
  /usr/bin/python2 get-pip2.py
  /usr/bin/python2 -m pip install pynvim
  rm get-pip2.py
fi

if ! command -v /usr/bin/python3 -m pip --version &> /dev/null
then
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip3.py
  /usr/bin/python3 get-pip3.py
  /usr/bin/python3 -m pip install pynvim
  /usr/bin/python3 -m pip install python-language-server
  rm get-pip3.py
fi




# SSH Keys
if [ ! -f "$HOME/.ssh/github" ]; then
  ssh-keygen -t ed25519 -C "eightpigs@outlook.com" -f /home/eightpigs/.ssh/github -q -P ""

  cat>~/.ssh/config<<EOF
Host github.com
  HostName github.com
  User eightpigs
  IdentityFile ~/.ssh/github
  PreferredAuthentications publickey
EOF

  echo 'Put below content into "https://github.com/settings/keys"'

  /usr/bin/cat ~/.ssh/github.pub
  read n
fi

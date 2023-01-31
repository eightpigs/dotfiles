# !/bin/bash

# Dir
mkdir -p $HOME/{Workspace,Downloads,.config}



# Python
# -----------------------------------------------------------------------------
if [ -f /usr/bin/python2 ]; then
	/usr/bin/python2 -m pip --version &> /dev/null
	if [ $? == 1 ]; then
		curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip2.py
		/usr/bin/python2 get-pip2.py
		rm get-pip2.py
	fi
	/usr/bin/python2 -m pip install pynvim
fi

if [ -f /usr/bin/python3 ]; then
  /usr/bin/python3 -m pip --version &> /dev/null
  if [ $? == 1 ]; then
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip3.py
    /usr/bin/python3 get-pip3.py
    rm get-pip3.py
  fi
  /usr/bin/python3 -m pip install pynvim
  /usr/bin/python3 -m pip install python-language-server
  pip3 install iredis
fi


# Rust
# -----------------------------------------------------------------------------
[ ! -f $HOME/.cargo/env ] && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install stylua --features lua54




# SSH Keys
# -----------------------------------------------------------------------------
if [ ! -f "$HOME/.ssh/github" ]; then
  ssh-keygen -t ed25519 -C "eightpigs@outlook.com" -f $HOME/.ssh/github -q -P ""

  cur_user=`users`
  cat>~/.ssh/config<<EOF
Host github.com
  HostName github.com
  User $cur_user
  IdentityFile ~/.ssh/github
  PreferredAuthentications publickey
EOF

  echo 'Put below content into "https://github.com/settings/keys"'

  /usr/bin/cat ~/.ssh/github.pub
  read n
fi


# Node Version Manager
# -----------------------------------------------------------------------------
nvm --version &> /dev/null
if [ $? == 1 ]; then
  latest_tag=`curl --silent "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | jq -r .tag_name`
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$latest_tag/install.sh | bash
fi

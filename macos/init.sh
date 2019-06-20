# Xcode toolchain
xcode-select --install

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# set hostname
sudo scutil --set HostName fighter.local

# gen sshkey
ssh-keygen -b 4096 -t rsa

# install neovim
brew install neovim --HEAD

# install tools
brew install cmake git boost autojump the_silver_searcher lrzsz nginx unrar mycli python2 ccat htop tmux python3 ctags fd fzf

# go dependences
curl https://glide.sh/get | sh

# mkdirs
mkdir  -p ~/Workspace/git/

# use zsh
chsh -s /bin/zsh

# use oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# rime inputSource, coloe repo && open project with xcode
# cd ~/Workspace/git/
# git clone --recursive https://github.com/rime/squirrel.git
# sudo xcode-select --reset
# make deps
# make
# sudo make install

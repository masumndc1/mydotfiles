#!/bin/bash

sudo port selfupdate
brew install zplug
sudo port install git bat lsd ripgrep fzf

curl -sL --proto-redir \
     -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh \
     | zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ~/.zshrc ~/.zshrc.bk
cp zshrc ~/.zshrc
zplug clean
zplug clear
zplug install

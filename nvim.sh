#!/bin/bash


# install nvim
if [[ `uname` == "Linux" ]]; then
    if [[ -f /usr/bin/apt ]]; then
        sudo apt-get install -y neovim python3-pynvim python3-msgpack python3-neovim libmsgpack-dev
    elif [[ -f /usr/bin/yum ]]; then
        sudo yum install -y neovim python3-pynvim python3-msgpack python3-neovim libmsgpack-dev
    fi
elif [[ `uname` == "Darwin" ]]; then
    sudo port install -y neovim python3-pynvim python3-msgpack libmsgpack-dev
fi

# place vimrc file
if [[ -f ~/.vimrc ]]; then
    cp ~/.vimrc ~/.vimrc.bk
    cp vimrc ~/.vimrc
else
    cp vimrc ~/.vimrc
fi

# use existing vimrc for nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# install all plug
if [ ! -f ~/.vim/autoload/plug.vim ] ; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ -f $(which nvim) ] ; then
  nvim -c 'PlugClean | PlugInstall | PlugUpdate | qa '
else
  vim -c 'PlugClean | PlugInstall | PlugUpdate | qa '
fi

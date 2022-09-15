#!/bin/bash -x
# powerline fonts

if [[ `uname` == "Linux" ]]; then
    if [[ ! -f "/usr/local/share/fonts/meslo" ]]; then
        mkdir /usr/local/share/fonts/meslo
        cp fonts/*.ttf /usr/local/share/fonts/meslo/
    else
        cp fonts/*.ttf /usr/local/share/fonts/meslo/
    fi
fi

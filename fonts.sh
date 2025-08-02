#!/bin/bash -x
# powerline fonts
# place the fonts in /usr/share/fonts directory
# run this as root user

if [[ $(uname) == "Linux" ]]; then
  echo -n "run this as root user"
  cp fonts/terminus/*.ttf /usr/share/fonts
fi

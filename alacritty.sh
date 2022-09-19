#!/bin/bash

sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.2 snappy
sudo zypper --gpg-auto-import-keys refresh
sudo zypper dup --from snappy
sudo zypper install snapd
sudo systemctl enable snapd
sudo systemctl start snapd
#Install alacritty
sudo snap install alacritty --classic

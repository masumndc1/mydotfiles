#!/usr/bin/env python3

import os
import shutil
import sys

from subprocess import check_call as call
from shutil import copy as cp

home = os.path.expanduser('~')
pkgs = {'bat','fzf','ripgrep','exa'}


def set_zsh(file):

    location_zsh_conf = home + "/." + file
    backup_zsh_conf = home + "/." + file + ".bk"

    if os.path.exists(location_zsh_conf):
        cp(location_zsh_conf, backup_zsh_conf)
        cp(file, location_zsh_conf)
    else:
        cp(file, location_zsh_conf)


def install_pkgs():
    for pkg in pkgs:
        if pkg == 'ripgrep':
            pkg_path = "/usr/bin/rg"
        else:
            pkg_path = "/usr/bin/" + pkg
        if not os.path.exists(pkg_path):
            call("sudo zypper install -y {}".format(pkg), shell=True)

def install_ohmyzsh():
    if os.path.exists("/usr/bin/zypper"):
        ohmyzsh_path = home + "/.oh-my-zsh"
        if not os.path.exists(ohmyzsh_path):
            call("curl -fsSL \
                https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
                | sh)", shell=True)

if __name__ == '__main__':
    if len(sys.argv) == 2:
        file = sys.argv[1]
        set_zsh(file)
        install_pkgs()
        install_ohmyzsh()
    else:
        print("set_zsh file_name")

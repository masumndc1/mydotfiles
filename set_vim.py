#!/usr/bin/env python3

import os
import requests
import shutil
import sys

from subprocess import check_call as call


home = os.path.expanduser('~')


def set_vim_plug():

    loc_vim_plug = home + "/.vim/autoload/plug.vim"

    if not os.path.exists(loc_vim_plug):
        print("[-] vim_plug is not installed")
        os.makedirs(os.path.dirname(loc_vim_plug), exist_ok=True)
        r = requests.get(
          "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        )
        with open(loc_vim_plug, 'wb') as f:
            f.write(r.content)


def set_vim(file):

    location_vim_conf = home + "/." + file
    backup_vim_conf = home + "/." + file + ".bk"

    if os.path.exists(location_vim_conf):
        shutil.copy(location_vim_conf, backup_vim_conf)
        shutil.copy(file, location_vim_conf)
    else:
        shutil.copy(file, location_vim_conf)


def install_nvim():

    if not os.path.exists("/usr/bin/nvim"):
        if os.path.exists("/usr/bin/zypper"):
            call("sudo zypper install -y neovim", shell=True)
        elif os.path.exists("/usr/bin/apt"):
            call("sudo apt-get install software-properties-common", shell=True)
            call("sudo add-apt-repository ppa:neovim-ppa/stable", shell=True)
            call("sudo apt update", shell=True)
            call("sudo apt install -y neovim", shell=True)
            call("sudo apt install python3-neovim", shell=True)
        elif os.path.exists("/usr/bin/yum"):
            call("sudo apt install -y yum", shell=True)
    else:
        print("we dont support this OS")


def symlink_nvim():
    vim_src = home + "/.vim"
    vim_dst = home + "/.config/nvim"
    vimrc_src = home + "/.vimrc"
    vimrc_dst = home + "/.config/nvim/init.vim"

    try:
        os.symlink(vim_src, vim_dst)
        os.symlink(vimrc_src, vimrc_dst)
    except FileNotFoundError:
        os.makedirs(vim_dst, exist_ok=True)
    except FileExistsError:
        print("[+] it has symlink already")


if __name__ == '__main__':
    if len(sys.argv) == 2:
        file = sys.argv[1]
        set_vim_plug()
        set_vim(file)
        install_nvim()
        symlink_nvim()
    else:
        print("set_vim vimrc")

#!/usr/bin/env python3

import os
import platform
import sys

from shutil import copy as cp
from subprocess import check_call as call

home = os.path.expanduser("~")
pkgs = {"bat", "fzf", "ripgrep", "exa", "tig", "lsd"}


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
        if "Darwin" in platform.system():
            pkg_path = "/usr/local/bin/"
        else:
            pkg_path = "/usr/bin/"

        if pkg == "ripgrep":
            pkg_location = pkg_path + "rg"
        elif "Darwin" in platform.system() and pkg == "fzf":
            continue
        elif os.path.exists("/usr/bin/zypper") and pkg == "exa":
            continue
        else:
            pkg_location = pkg_path + pkg

        if not os.path.exists(pkg_location):
            if "Darwin" in platform.system():
                call("sudo port install -y {}".format(pkg), shell=True)
            elif "OpenSuse" in platform.system() or os.path.exists("/usr/bin/zypper"):
                call("sudo zypper install -y {}".format(pkg), shell=True)
            elif "Linux" in platform.system():
                if "debian" in platform.uname() or "ubuntu" in platform.uname():
                    call("sudo apt-get install -y {}".format(pkg), shell=True)
            else:
                print("[-] we dont support this OS atm")


if __name__ == "__main__":
    if len(sys.argv) == 2:
        file = sys.argv[1]
        set_zsh(file)
        install_pkgs()
    else:
        print("set_zsh file_name")

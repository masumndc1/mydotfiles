#!/usr/bin/env python3

import os
import shutil
import sys


def set_tmux(file):

    home = os.path.expanduser('~')
    location_tmux_conf = home + "/." + file
    backup_tmux_conf = home + "/." + file + ".bk"

    if os.path.exists(location_tmux_conf):
        shutil.copy(location_tmux_conf, backup_tmux_conf)
        shutil.copy(file, location_tmux_conf)
    else:
        shutil.copy(file, location_tmux_conf)


if __name__ == '__main__':
    if len(sys.argv) == 2:
        file = sys.argv[1]
        set_tmux(file)
    else:
        print("set_tmux file_name")

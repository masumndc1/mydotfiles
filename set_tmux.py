#!/usr/bin/env python3

import os
import shutil
import sys
import subprocess


def set_tmux(file):

    home = os.path.expanduser('~')
    location_tmux_conf = home + "/." + file
    backup_tmux_conf = home + "/." + file + ".bk"
    plugin_location = home + "/.tmux/plugins/tpm"

    if os.path.exists(location_tmux_conf):
        shutil.copy(location_tmux_conf, backup_tmux_conf)
        shutil.copy(file, location_tmux_conf)
    else:
        shutil.copy(file, location_tmux_conf)

    if not os.path.exists(plugin_location):
        subprocess.check_output(
            f"git clone https://github.com/tmux-plugins/tmp {plugin_location}",
            shell=True)
    else:
        print("tpm location is set")


if __name__ == '__main__':
    if len(sys.argv) == 2:
        file = sys.argv[1]
        set_tmux(file)
    else:
        print("set_tmux file_name")

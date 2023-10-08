#!/usr/bin/env python3

import os
import shutil

gitconfig = os.path.expanduser('~') + '/.gitconfig'
gitconfig_themes = os.getcwd() + '/themes_gitconfig'
themes_des = os.path.expanduser('~') + '/themes_gitconfig'
delta_conf = """
[user]
    name =
    email =

[pull]
    rebase = true

[core]
    pager = delta

[include]
  path = ~/themes_gitconfig

[interactive]
    diffFilter = delta --color-only

[delta]
    features = mellow-barbet
    side-by-side = true
    navigate = true
    light = false
    line-numbers = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default

[color]
    ui = auto

[log]
    date = short

[format]
    pretty = '%C(yellow)%h%Creset %C(magenta)%cd%Creset %d %s'
"""


def setup_themesfile():
    if os.path.exists(gitconfig_themes):
        shutil.copy(gitconfig_themes, themes_des)


def setup_delta(path):
    if os.path.exists(path):
        with open(path, 'r+') as f:
            if delta_conf not in f.read():
                f.seek(10)
                f.write(delta_conf)


def main():
    setup_themesfile()
    if os.path.exists(gitconfig):
        setup_delta(gitconfig)
    else:
        print('we could not find the gitconfig file')


if __name__ == "__main__":
    main()

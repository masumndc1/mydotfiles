#!/usr/bin/env python3

import os

gitconfig = os.path.expanduser('~') + '/.gitconfig'
delta_conf = """
[user]
    name = Khabir Uddin
    email = khuddin@csc.fi

[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    light = false
    side-by-side = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
"""


def setup_delta(path):
    if os.path.exists(path):
        print(path)
        with open(path, 'r+') as f:
            if delta_conf not in f.read():
                f.write(delta_conf)


def main():
    if os.path.exists(gitconfig):
        setup_delta(gitconfig)
    else:
        print('we could not find the gitconfig file')


if __name__ == "__main__":
    main()

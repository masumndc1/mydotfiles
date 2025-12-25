#!/usr/bin/env python3
# this script will install git and place git repos

import os
import subprocess
import sys

GITDIR = os.path.expanduser("~") + "/Documents/github"
REPOS = ["infrastructure", "management", "mydotfiles", "puppet-bolt", "zim"]
USER = "masumndc1"


def mydir():
    gitdir = GITDIR
    if os.path.exists(gitdir):
        return gitdir
    else:
        sys.exit("~/Documents/github does not exists")


def git_repo(repo):
    user = USER
    # subprocess.call("git clone git@github.com:{}/{}.git".format(user, repo))
    cmd = "git clone https://github.com/{}/{}.git".format(user, repo)
    subprocess.call(cmd, cwd=os.chdir(mydir()), shell=True)


def main():
    for repo in REPOS:
        git_repo(repo)


if __name__ == "__main__":
    main()

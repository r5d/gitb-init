#!/bin/sh

# Copyright 2017 rsiddharth <s@ricketyspace.net>
#
# This work is free. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar. See the COPYING file or
# <http://www.wtfpl.net/> for more details.

usage ()
{
    echo '\n  Usage: '\
         '\n\n'\
         '    ./gitb-init.sh REPO_NAME [REPOS_DIR] [REMOTE_HOST]'\
         '\n'\
         '\n        REPOS_DIR   - Bare repos directory; if not specified'\
         '\n                      $GITBI_DIR is used.'\
         '\n'\
         '\n        REMOTE_HOST - Remote host name (user@host.name); if'\
         '\n                      not specfied $GITBI_HOST is used'\
         '\n  Examples: '\
         '\n\n'\
         '    ./gitb-init.sh project-snafu.git vcs/git/projects user@fortytwo.net\n'\
         '\n         Will install bare git repository $HOME/vcs/git/projects/project-snafu.git'\
         '\n         at host fortytwo.net.'\
         '\n\n'\
         '    ./gitb-init.sh project-snafu.git vcs/git/projects\n'\
         '\n         Will install bare git repository $HOME/vcs/git/projects/project-snafu.git'\
         '\n         at host defined by environment variable $GITBI_HOST.'\
         '\n\n'\
         '    ./gitb-init.sh project-snafu.git\n'\
         '\n         Will install bare git repository $HOME/GITBI_DIR/project-snafu.git'\
         '\n         at host defined by environment variable $GITBI_HOST, where path GITBI_DIR'\
         '\n         is defined by environment variable $GITBI_DIR.'\
         '\n'
}

ssh_cmd()
{
    ssh <<-EOF $REMOTE_HOST\
        'mkdir -p '$REPO_PATH\
        '&& cd '$REPO_PATH\
        '&& git init --bare'\
        '&& mv hooks/post-update.sample hooks/post-update'
EOF
}

# Get repo name.
if [ ! -z $1 ]; then
    REPO_NAME=$1
else
    echo 'ERROR: Repo name not specified.'
    usage
    exit 1
fi

# Get repos directory name.
if [ ! -z $2 ]; then
    REPOS_DIR=$2
elif [ ! -z $GITBI_DIR ]; then
    REPOS_DIR=$2
else
    echo 'ERROR: Bare repos directory not specified.'
    usage
    exit 1
fi

# Get remote host.
if [ ! -z $3 ]; then
    REMOTE_HOST=$3
elif [ ! -z $GITBI_HOST ]; then
    REMOTE_HOST=$GITBI_HOST
else
    echo 'ERROR: Host not specified.'
    usage
    exit 1
fi

REPO_PATH=$REPOS_DIR'/'$REPO_NAME

ssh_cmd


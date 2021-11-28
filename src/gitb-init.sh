#!/bin/sh

# Copyright 2017 rsiddharth <s@ricketyspace.net>
#
# This work is free. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar. See the LICENSE file or
# <http://www.wtfpl.net/> for more details.

usage ()
{
    echo
    cat <<-EOF
  Usage:

     ./gitb-init.sh REPO_NAME [REPOS_DIR] [REMOTE_HOST]

               REPOS_DIR   - Bare repos directory; if not specified
                             $GITBI_DIR is used.

               REMOTE_HOST - Remote host name (user@host.name); if
                             not specfied $GITBI_HOST is used
     Examples:
         ./gitb-init.sh project-snafu.git vcs/git/projects user@fortytwo.net
              Will install bare git repository $HOME/vcs/git/projects/project-snafu.git
              at host fortytwo.net.

         ./gitb-init.sh project-snafu.git vcs/git/projects
              Will install bare git repository $HOME/vcs/git/projects/project-snafu.git
              at host defined by environment variable $GITBI_HOST.

         ./gitb-init.sh project-snafu.git
              Will install bare git repository $HOME/GITBI_DIR/project-snafu.git
              at host defined by environment variable $GITBI_HOST, where path GITBI_DIR
              is defined by environment variable $GITBI_DIR.
EOF
}

ssh_cmd()
{
    ssh <<-EOF "$REMOTE_HOST"\
        'mkdir -p '"$REPO_PATH"\
        '&& cd '"$REPO_PATH"\
        '&& git init --bare'\
        '&& mv hooks/post-update.sample hooks/post-update'
EOF
}

# Get repo name.
if [ -n "$1" ]; then
    REPO_NAME=$1
else
    echo 'ERROR: Repo name not specified.'
    usage
    exit 1
fi

# Get repos directory name.
if [ -n "$2" ]; then
    REPOS_DIR=$2
elif [ -n "$GITBI_DIR" ]; then
    REPOS_DIR=$GITBI_DIR
else
    echo 'ERROR: Bare repos directory not specified.'
    usage
    exit 1
fi

# Get remote host.
if [ -n "$3" ]; then
    REMOTE_HOST=$3
elif [ -n "$GITBI_HOST" ]; then
    REMOTE_HOST=$GITBI_HOST
else
    echo 'ERROR: Host not specified.'
    usage
    exit 1
fi

REPO_PATH=$REPOS_DIR'/'$REPO_NAME

ssh_cmd


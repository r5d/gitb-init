#!/bin/sh

# Copyright 2014 rsiddharth <rsiddharth@ninthfloor.org>
#
# This work is free. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar. See the COPYING file or
# <http://www.wtfpl.net/> for more details.

repo_name=$1

git_dir="git" # default location relative to remote $HOME. change it if you want.
ssh_login="user@servername.tld" # default ssh_login. you must change this.

if [ -n "$2" ]; then
	git_dir=$2
fi

repo_path="$git_dir/$repo_name"

if [ -n "$3" ]; then
	ssh_login=$3
fi

ssh_cmd="mkdir -p $repo_path && cd $repo_path && git init --bare && mv hooks/post-update.sample hooks/post-update"
ssh $ssh_login $ssh_cmd

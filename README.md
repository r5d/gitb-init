# gitb-init

A dumb script that sets up a bare remote git repository for pushing &
pulling using the dumb protocol.

## usage

    $ src/gitb-init.sh gitreponame.git [git_dir] [ssh_login]

The command creates a remote bare repository `gitreponame.git` under
`git_dir` directory on the remote server.

**defaults**

    git_dir="git"
    ssh_login="user@servername.tld"

`git_dir` is the directory under which the remote bare git repo is
created. Change this variable's value as you see fit.

`ssh_login` is set to a dummy value, you must set this.

## contact

**rsiddharth** <rsiddharth@ninthfloor.org>

## license

The script is under the [WTFPL version 2 license][3]. See COPYING for more
details. This license is [compatible with GNU GPL][4].

[3]: http://www.wtfpl.net/txt/copying/
[4]: http://www.gnu.org/licenses/license-list.html#WTFPL

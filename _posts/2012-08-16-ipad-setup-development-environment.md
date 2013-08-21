---
layout: post
title: Setup the iPad for a (Python) development environment
comments: true
---

This post is a guide on how to turn the iPad in to a (mobile) development
terminal.  I will install Python 2.7, vim, git and tmux. You can then use your
favorite SSH app from the AppStore to login to the remote shell of your iPad
and go nuts.  I like Prompt.

<!-- more -->

### 0. Before you begin

Every compiled program needs to be signed otherwise this will not run on the
ipad.  You can save the code below in a file and run it by sypplying the path
to the `configure` file.  This will prepend the `ldid` pseudo code sign
statements in the correct places. Now the `./configure` command will execute
successfully.

    #!/bin/bash
    # Save this as sign_configure_file.sh
    # Usage: sign_configure_file.sh path/to/configure

    sed --in-place '/(eval "$ac_try")/i\
      eval "ldid -S ./conftest$ac_cv_exeext"' $1


### 1. Jailbreak and Cydia

First you need to have a jailbroken iPad an Cydia installed.

### 2. Install some essential tools

Before we install gcc so we can compile the tools we need we install some
standard applications used in most development environments.

    apt-get install adv-cmds


### 3. Install gcc compiler


### 4. Git and Vim

    # add ldid -S to ./configure file
    $ ./configure --prefix=/usr/local
    $ make NO_PERL=1 NO_TCLTK=1 prefix=/usr/local
    $ make NO_PERL=1 NO_TCLTK=1 prefix=/usr/local install
    $ ldid -S git

    # add ldid -S to ./configure file
    $ ./configure --enable-multibyte --with-features=huge --disable-darwin --with-tlib=ncurses
    $ make
    $ make install
    $ ldid -S /usr/local/bin/vim
    

### 5. Python

Then we can install setuptools and pip:

    $ curl http://python-distribute.org/distribute_setup.py | python
    $ curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python

    $ cd /usr/local/lib/python2.7/site-packages/

### 6. Tmux

The ncurses library should be installed by cydia by default. Make sure the
version is 5.x

Now install libevent 2.x first

    # http://libevent.org/
    $ tar xvzf libevent-XXX.tar.gz .
    $ cd libevent-XXX
    # add ldid -S to ./configure file
    $ ./configure --prefix=/usr/local
    $ make
    $ make install

Now we can install tmux

    # http://tmux.sourceforge.net/
    wget http://downloads.sourceforge.net/tmux/tmux-1.6.tar.gz
    tar xvzf tmux-1.6.tar.gz
    cd tmux
    ./configure --prefix=/usr/local
    make
    make install
    ldid -S /usr/local/bin/tmux
    

 

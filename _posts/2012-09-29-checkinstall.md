---
layout: post
title: A checkinstall howto
comments: true
---

This howto explains how you can compile a package from source and install it
using your package manager so you can easily uninstall your package later 
(without leaving too many scattered files around.

<!-- more -->

## Installing checkinstall

    sudo apt-get install checkinstall


## Compile from source

First of all get a program of your choice that you will compile from source.
In the following example we will compile and install tmux, assuming that you
already have libevent 1.4+ and ncurses installed (in the default locations).

    cd /tmp
    wget http://downloads.sourceforge.net/tmux/tmux-1.6.tar.gz
    tar xvzf tmux-1.6.tar.gz
    cd tmux-1.6
    ./configure
    make
    make test

Now instead of running  `make install` we use checkinstall instead

    checkinstall -D make install

Follow the interactive installation by providing package information.
Once succesful you can see the package appear when doing `dpkg -l`.

To uninstall tmux again you can your package manager like `dpkg` or `apt-get`
in debian based Unix OS'es

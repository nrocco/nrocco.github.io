---
layout: post
title: Setup GIT server
---

Host git repositories over ssh for personal use.

<!-- more -->

# Setup Git Server

    $ mkdir /srv/git
    $ chown git:git /srv/git
    $ groupadd --system git
    $ useradd --system --user-group --home /srv/git --shell /usr/bin/git-shell git


# LOCAL ACCESS Add normal day-to-day user to the git group

    $ usermod -a -G git <user>


# REMOTE ACCESS

    $ mkdir -p /srv/git/.ssh
    $ touch /srv/git/.ssh/authorized_keys
    $ chmod 700 /srv/git/.ssh
    $ chmod 600 /srv/git/.ssh/authorized_keys


# Create a new git repository

    $ cd /srv/git
    $ git init --bare --shared=group <repo_name.git>
    $ chown -R git:git <repo_name.git>
    $ chmod -R g+w <repo_name.git>


# Example

    $ git clone git@hostname.com:repo_name.git

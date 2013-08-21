---
layout: post
title: Some usefull git-svn commands
comments: true
---

Here are some useful git-svn commands that I found really usefull when working
in a SVN oriented environment.

<!-- more -->

## Start a new project with /trunk /branches /tags

    mkdir /srv/www/projectname
    cd /srv/www/projectname
    git svn init -s svn://svn.somedomain.com/appname .
    git svn fetch
    git svn show-ignore >> .git/info/exclude


## Create a remote (svn)branch based on /trunk
    
    # make sure you have a clean working directory
    git checkout master
    git svn branch -m "MESSAGE" some_branch_name

    # List all remote branches
    git branch -r

    # Have a look at a remote branch
    git checkout some_branch_name

    # Checkoout the remote branch and create a local branch with the same name
    git checkout -b some_branch_name


## Start a new project with only trunk

    mkdir /srv/www/projectname
    cd /srv/www/projectname
    git svn init --trunk=trunk svn://svn.somedomain.com/appname .
    git svn fetch
    git svn show-ignore >> .git/info/exclude


## Get changes from Subversion server

I advise you to run the following often. This way you will stay up to date
with changes from the central subversion repository.

    # Stash everything that you do not want to commit to svn so you have a clean working directory
    git stash
    # Get the latest changes from subversion
    git svn rebase
    git stash apply


## Sample commit to svn via git

    # Commit something to your local git repository

    git stash
    git svn rebase
    git svn dcommit -n    #dry run
    git svn dcommit
    git stash apply

---
layout: post
title: Manage supervisord processes securely
comments: true
---

Allow your regular unix user to manage supervisor processes.

<!-- more -->

    $ sudo apt-get install python supervisord

    $ groupadd supervisor
    $ usermod -a -G supervisor {a_unix_username}

    $ vim /etc/supervisor/supervisord.conf
    # Change:
    #     chmod=0770
    #     chown=root:supervisor

    $ service supervisor stop
    $ service supervisor start
    # don't try restart, that will not re-create the socket if it was already created.

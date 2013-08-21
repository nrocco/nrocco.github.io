---
layout: post
title: Disable AppArmor
comments: true
---

Sometimes apparmor is installed by default. Follow these steps to disable it.

<!-- more -->

# Disable AppArmor

    $ /etc/init.d/apparmor stop
    $ /etc/init.d/apparmor teardown
    $ update-rc.d -f apparmor remove
    $ aptitude remove apparmor apparmor-utils --purge

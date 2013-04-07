---
layout: post
title: Disable AppArmor
---

# Disable AppArmor

    $ /etc/init.d/apparmor stop
    $ /etc/init.d/apparmor teardown
    $ update-rc.d -f apparmor remove
    $ aptitude remove apparmor apparmor-utils --purge

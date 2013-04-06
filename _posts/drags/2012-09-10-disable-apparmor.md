---
layout: post
title: Disable AppArmor
---

Title:     Disable AppArmor
Slug:      disable-apparmor
Date:      2012-09-10 21:17
Tags:    
Status:    draft


# Disable AppArmor

    $ /etc/init.d/apparmor stop
    $ /etc/init.d/apparmor teardown
    $ update-rc.d -f apparmor remove
    $ aptitude remove apparmor apparmor-utils --purge

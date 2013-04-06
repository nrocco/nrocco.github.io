---
layout: post
title: A logrotate example
---

# Sample configuration file

    /directory/to/log/*.log {
        size 10M
        rotate 10
        missingok
        nocompress
        notifempty
        sharedscripts
    }


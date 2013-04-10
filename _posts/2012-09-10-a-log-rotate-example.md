---
layout: post
title: A logrotate example
---

This is a very simple sample logrote file.

<!-- more -->

# Sample configuration file

    /directory/to/log/*.log {
        size 10M
        rotate 10
        missingok
        nocompress
        notifempty
        sharedscripts
    }


---
layout: post
title: Create reusable MySQL dump
comments: true
draft: yes
---

Another draft post

<!-- more -->

# Create mysql dump

    $ mysqldump -uUSER -p DATABASENAME --single-transaction --quick --skip-add-drop-table --result-file=/tmp/database.sql
    $ gzip /tmp/database.sql

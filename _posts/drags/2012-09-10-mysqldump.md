---
layout: post
title: Create reusable MySQL dump
---

Title:     Create reusable MySQL dump
Slug:      mysqldump
Date:      2012-09-10 21:15
Tags:    
Status:    draft

# Create mysql dump

    $ mysqldump -uUSER -p DATABASENAME --single-transaction --quick --skip-add-drop-table --result-file=/tmp/database.sql
    $ gzip /tmp/database.sql

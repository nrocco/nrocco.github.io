---
layout: post
title: Compression in Linux
draft: true
---

# Gzip archives

    # Create a tar archive from multiple directories
    sudo tar czf 2011.12.11_backup.tar.gz /var/git /var/www /var/backup /etc /home

    # Look inside a tar archive without unzipping anything
    gunzip -c filename.tar.gz | tar -tvf - | less

    # Extract a single file from the tar archive
    gunzip -c filename.tar.gz | tar -xvf - path/within/archive/filename.py

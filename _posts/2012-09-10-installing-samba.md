---
layout: post
title: Installing and configuring Samba
---

A tutorial on how to install samba to expose a share to clients.

<!-- more -->

Installing and configuring Samba
================================

1) Install Samba
    
    sudo apt-get install samba4 // not needed because samba 3.x is installed by default

2) Open the Samba config file

    sudo nano /etc/samba/smb.conf

3) Add following to end of file

    [www]
        path = /var/www
        read only = no
        browsable = yes
        create mask = 0755
        guest ok = no
        veto files = /.svn/

4) Create a new samba user

    sudo smbpasswd –a <username>

5) Restart Samba deamon

    sudo /etc/init.d/samba4 restart // or if you use preinstalled samba 3.x
    sudo restart smbd

6) Ignore errors

7) Now access share in windows through `\<ipaddress>\www`

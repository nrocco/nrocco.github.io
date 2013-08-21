---
layout: post
title: Boot and bypass root for vm
comments: true
---

A usefull tip to reset a root password for a virtual machine in case you've
lost it

<!-- more -->

## Log in to a unix system with a lost root account

In vSphere client, turn on the VM you would like to have access to.

    Press left shift at boot

In GRUB highlight the kernel you would like to boot and press 'e' for edit (do
not press enter).

At the one-to-last line append:

    single init=/bin/bash


## Change the root password.

The drive is now mounted in read-only mode. Remount it as a writable drive and
you are ready to reset the root password.

    $ mount -o remount,rw /
    $ sync
    $ passwd root
    # Enter your new password for the root user twice.
    $ sync

Probably the reboot and shutdown commands do not work because we have
overwritten the init process. Use vSphere client to reboot/reset the virtual
machine.

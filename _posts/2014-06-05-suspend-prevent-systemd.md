---
layout: post
title: Prevent suspend on lid close with systemd
tags: [systemd, archlinux]
comments: true
---

By default systemd suspends your system when you close the lid (of your
laptop). While this default behavior is acceptable in most cases, for me it posed a
problem.

This post explains how you can prevent your system from sleeping when closing
the lid of your laptop only when connected to AC.


<!-- more -->

When I work on my laptop and close the lid I like the fact that my system goes
to sleep. This is similar behaviour Apple Macbooks have when you close the
lid. And I like it.

At work we use docking stations. Many times a day I get up from my desk an
have to take my laptop with me. Resulting in many docking/undocking actions a
day.

Everytime I dock my laptop I close the lid. Within a few seconds my system
goes to sleep and I need to wake it up by pressing the power button on my
docking station before I can start working again.

Months go by and I am getting more and more frustrated by these precious time
I loose suspending/unsuspending my system.  I don't want to drag in any 3rd
party tools/scripts/daemons that can lift this burdon. I like to stick to plain
system and a plain systemd and keep my system as clean as possible.

At some point I decided that everytime I dock my laptop I just leave my lid
open just a bit, preventing it from going in to sleep mode and allowing me to
use that precious time.

This worked for a while but very soon you are being ridiculed by your
collegues as `the systemd user with his half-closed-lid` and everytime they
pass by they can't help giving my laptop a friendly tap-on-the-back, forcing
it to go in to sleep mode. I can't blame them.

The following solution came to mind.


I created the following script `/usr/local/bin/suspend-prevent`

    % cat /usr/local/bin/suspend-prevent
    #!/bin/sh

    SYSTEMCTL=/usr/bin/systemctl

    case "$1" in
        battery)
            echo 'Running on battery. Making sure to remove the inhibit lock'
            $SYSTEMCTL stop suspend-prevent.service
            ;;

        ac)
            echo 'Running on AC. Making sure to add the inhibit lock'
            $SYSTEMCTL start suspend-prevent.service
            ;;

        -h|--help|help)
            echo "Usage: $(basename $0) [battery|ac|--forever]"
            exit 1
            ;;

        --forever)
            /usr/bin/systemd-inhibit --what=handle-lid-switch:sleep --who=$(id -un $(whoami)) --why="Prevent suspend on lid close when on AC" --mode=block /usr/bin/bash -c "while true; do sleep 60; done"
            ;;

        *)
            echo 'Automatically detecting power source...'

            if cat /sys/class/power_supply/AC/online | grep 0 > /dev/null 2>&1
            then
                $0 battery
            else
                $0 ac
            fi

            exit $?
            ;;
    esac

    exit 0


The script is very easy to understand. By either using command line arguments
`battery` and `ac` (or by omitting command line arguments) the script starts
or stops a systemd service, depending on the current status of the AC adapter.

The systemd service `suspend-prevent.service` looks like this:

    % cat /etc/systemd/system/suspend-prevent.service
    [Unit]
    Description=Prevent suspend on lid close when on AC

    [Service]
    Type=simple
    ExecStart=/usr/local/bin/suspend-prevent --forever


As you can see it calls the previous script with the `--forever` command line
option. This effectively creates a systemd inhibit lock preventing the system
from going to sleep when the lid is closed.

When the `suspend-prevent.service` is stopped, the inhibit lock is removed.


If combined with the following udev rules:

    % cat /etc/udev/rules.d/50-suspend-prevent.rules
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="/usr/local/bin/suspend-prevent battery"
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="/usr/local/bin/suspend-prevent ac"


Everytime you plug your laptop to AC (or docking it) a systemd inhibit lock is
set which looks like this:

    % systemd-inhibit
         Who: root (UID 0/root, PID 303/systemd-inhibit)
        What: sleep:handle-lid-switch
         Why: Prevent suspend on lid close when on AC
        Mode: block

    1 inhibitor listed.


If you undock your laptop (or unplug it from AC) the inhibit lock is removed.

Now I can dock my laptop and close the lid of my laptop without my system
going in to sleep mode. And when I am on battery, if I close my lid, I still
get the 'Macbook' style behaviour and my system is going to sleep.
This is exactly the behaviour I was aiming for.

A finishing touch to all this is another systemd service which runs at boot at
determines if the laptop is using AC or battery. Depending on the outcome it
will set the inhibit lock. I needed this extra service allowing me to dock my
laptop while powered off (e.g. when I arrive at work in the morning):

    % cat /etc/systemd/system/suspend-prevent-atboot.service 
    [Unit]
    Description=Determine during boot if inhibit lock needs to be set or not
    After=dbus.service

    [Service]
    ExecStart=/usr/local/bin/suspend-prevent

    [Install]
    WantedBy=multi-user.target


Interesting reads that gave me this idea:

- https://bbs.archlinux.org/viewtopic.php?id=171149
- http://www.robert.orzanna.de/simplistic-powersaving-with-systemd-service-files-and-udev-rules/

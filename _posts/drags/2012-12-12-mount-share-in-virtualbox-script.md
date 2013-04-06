---
layout: post
title: A script to mount a share inside VirtualBox
---

Title:      A script to mount a share inside VirtualBox
Slug:       mount-share-in-virtualbox-script
Date:       2012-12-12 06:05
Tags:       unix, virtual, vm, guest, host

This is a simple script to ease the process of mounting and unmounting
a Virtual Box share

<!-- more -->

    #!/bin/bash
    #===================================================================
    #
    #         FILE:  vboxmounter
    #
    #        USAGE:  ./vboxmounter
    #
    #  DESCRIPTION:  Mounts shares from the Virtual Box host environment
    #      OPTIONS:  ---
    # REQUIREMENTS:  mount, umount
    #         BUGS:  ---
    #        NOTES:  ---
    #       AUTHOR:  Nico Di Rocco <dirocco.nico@gmail.com>
    #      COMPANY:  CasaDiRocco.nl
    #      VERSION:  1.0
    #      CREATED:  2012-02-17
    #     REVISION:  ---
    #===================================================================

    #===================================================================
    red=$(tput setaf 1)
    grn=$(tput setaf 2)
    ylw=$(tput setaf 3)
    blu=$(tput setaf 4)
    mgn=$(tput setaf 5)
    cya=$(tput setaf 6)
    wht=$(tput setaf 7)
    end=$(tput sgr0)

    cecho() {
      echo -e "${2}${1}${end}"
    }
    isok() {
      cecho "$1" ${green}
    }
    nook() {
      cecho "$1" ${red}
    }
    #===================================================================

    mount_share()
    {
      if [ ! -d "/media/$SHARE" ]; then
        sudo mkdir /media/$SHARE
      fi
      sudo mount -t vboxsf $SHARE /media/$SHARE
    }

    unmount_share()
    {
      sudo umount /media/$SHARE
    }

    HELP_TEXT="Usage: `basename $0` [attach|detach] name-of-share"

    if [ $# -ne 2 ]; then
      nook "Bad amount of arguments"
      echo "$HELP_TEXT"
      exit 65
    fi

    ACTION=$1
    SHARE=$2

    case $ACTION in
      "attach") 
        echo "Mounting $SHARE to /media/$SHARE"
        mount_share
        isok "Share $SHARE successfully mounted."
      ;;
      "detach") 
        echo "Unmounting $SHARE from /media/$SHARE"
        unmount_share
        isok "Share $SHARE successfully unmounted."
      ;;
      "help") 
        echo "$HELP_TEXT"
      ;;
      *) 
        nook "Not a valid action."
        echo "$HELP_TEXT" 
        exit 1
      ;;
    esac

    exit 0

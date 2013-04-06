---
layout: post
title: A Arch Linux install guide
---

Title:    A Arch Linux install guide
Slug:     arch-linux-install-guide
Status:   draft
Tags:     linux, ssh, bash, arch, unix

# Update the system with newest packages

    nano /etc/pacman.d/gnupg/gpg.conf
    # change keyserver to hkp://pgp.mit.edu
    pacman-key --init
    # do find / in other terminals for entrophy!

    for key in 6AC6A4C2 824B18E8 4C7EA887 FFF97E7 CDFD6BB0; do
        pacman-key --recv-keys $key
        pacman-key --lsign-key $key
        printf 'trust
3
quit
' | gpg --homedir /etc/pacman.d/gnupg/ --no-permission-warning --command-fd 0 --edit-key $key
    done

    pacman -Syy
    pacman -Syu




# Install sudo, yaourt, findutils and bash-completion
# Run `sudo updatedb` afterwards

    $ pacman -S sudo bash-completion
    $ pacman -S curl git svn
    $ pacman -S mlocate findutils
    $ pacman -S base-devel
    $ curl -o PKGBUILD http://aur.archlinux.org/packages/cower/PKGBUILD && makepkg -si
    $ curl -o PKGBUILD http://aur.archlinux.org/packages/pacaur/PKGBUILD && makepkg -si
    $ pacaur -S pacman-color cacheclean


# Add a new user

    $ groupadd ...
    $ useradd ...
    $ passwd ...


# Install devops tools

    pacman -S vim colordiff
    pacman -S ranger
    pacaur -S ctags


# Install basic web server

    pacman -S nginx sqlite3
    pacaur -S pacaur -S php php-fpm php-intl php-apc


# Install the Virtual Box guest addtions

    pacman -S virtualbox-archlinux-additions


# Install X-Server and window manager

    pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils xorg-xfontsel
    pacman -S i3 dmenu
    pacman -S ttf-dejavu 
    pacaur -S ttf-ms-fonts ttf-google-webfonts
    pacman -S alsa-utils
    pacaur vimprobable2-git
    pacaur -S rxvt-unicode-patched
    pacaur -S urxvt-clipboard


# Install

    pacman -S keychain


# Install some graphical tools

    # Remote desktop stuff
    pacman -S rdesktop tightvnc x11vnc

    # Password Manager
    pacman -S keepassx

    # PDF Viewer
    pacman -S xpdf

























# Build an AUR package

    wget http://aur.archlinux.org/path/to/the/tarball
    untargz thetarball.tar.gz
    cd thetarball
    makepkg -s
    pacman -U path/to/the/newly/created/tar.gz


# Install ctags

    wget http://ctags.sourceforge.net/path_to_the_package.tar.gz
    untargz path_to_the_package.tar-gz
    cd path_to_the_package
    ./confige
    make
    make install


sudo nano /etc/rc.conf

    CONSOLEFONT="viscii10-8x16"
    LOCALE="en_US.UTF-8"
    LOCALE
    MODULES=( .... vboxguest vboxsf vboxvideo)
    DAEMONS=( .... alsa)

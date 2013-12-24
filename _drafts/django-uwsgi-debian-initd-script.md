---
layout:     post
title:      Django Uwsgi init.d script
comments:   true
---

I started using [Supervisord][supervisord] for managing my django application
servers. But on a low budget VPS where RAM is scarce I decided to look for
alternatives. Inspired by the minimal philosophy of [Arch][the_arch_way] I
went for the [Init Scripts][init_scripts].

<!-- more -->

Suppose I have a django project called cookbook in `/srv/www/cookbook`.

I create the following init.d start up script:

    #!/bin/sh
    ### BEGIN INIT INFO
    # Provides:          cookbook
    # Required-Start:    $remote_fs $syslog
    # Required-Stop:     $remote_fs $syslog
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Short-Description: The cookbook application server
    # Description:       Manage the uwsgi/django app
    #                    Place this scrip in /etc/init.d/
    ### END INIT INFO

    # Author: Nico Di Rocco <dirocco.nico@gmail.com>

    PATH=/usr/local/bin:/sbin:/usr/sbin:/bin:/usr/bin

    NAME='cookbook'
    DESC='cookbook'

    RUNDIR='/var/run/uwsgi'
    PID_FILE="$RUNDIR/$NAME.pid"

    DAEMON='/usr/local/bin/uwsgi'
    DAEMON_ARGS="--ini /etc/uwsgi/$NAME.ini --pidfile $PID_FILE"


    # Gracefully exit if daemon not installed
    [ -x "$DAEMON" ] || return 5

    # Load some sensible defaults
    [ -r /etc/default/$NAME ] && . /etc/default/$NAME

    # Checks if directory exists that contains run time files
    [ -d "$RUNDIR" ] || mkdir -p "$RUNDIR"

    # Load the VERBOSE setting and other rcS variables
    . /lib/init/vars.sh

    # Define LSB log_* functions.
    # Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
    . /lib/lsb/init-functions



    case "$1" in
      start)
          if [ -e $PID_FILE ]; then
            status_of_proc -p $PID_FILE $DAEMON "$NAME process" && status="0" || status="$?"
            if [ 0 -eq "$status" ]; then
              exit 0
            fi
          fi

          log_daemon_msg "Starting $NAME"
          $DAEMON $DAEMON_ARGS

          if [ 0 -eq "$?" ]; then
            log_end_msg 0
          else
            log_end_msg 1
          fi
          ;;
      stop)
          if [ -e $PID_FILE ]; then
            status_of_proc -p $PID_FILE $DAEMON "Stoppping $NAME process" && status="0" || status="$?"
            if [ "$status" = 0 ]; then
              $DAEMON --stop $PID_FILE
              /bin/rm -rf $PID_FILE
              log_end_msg 0
            fi
          else
            log_daemon_msg "$NAME process is not running"
            exit 0
          fi
          ;;
      restart|force-reload)
          $0 stop && sleep 2 && $0 start
          ;;
      status)
          # Check the status of the process.
          if [ -e $PID_FILE ]; then
            status_of_proc -p $PID_FILE $DAEMON "$NAME" && exit 0 || exit $?
          else
            log_daemon_msg "$NAME is not running"
            log_end_msg 3
          fi
          ;;
      reload)
          if [ -e $PID_FILE ]; then
            status_of_proc -p $PID_FILE $DAEMON "Reloading $NAME process" && status="0" || status="$?"
            if [ "$status" = 0 ]; then
              $DAEMON --reload $PID_FILE
              log_success_msg "$NAME reloaded successfully"
            fi
          else
            log_failure_msg  "$NAME process is not running"
          fi
          ;;
      *)
          echo "Usage: sudo service $NAME {start|stop|restart|reload|force-reload|status}"
          exit 2
        ;;
    esac

    exit 0


I can now use `sudo service cookbook status` to see if my application is
running or not. `sudo service cookbook start` to start it and `sudo service
cookbook stop` to stop it. The uwsgi daemon starts with the following options
defined in an external `.ini` file from `/etc/uwsgi/cookbook.ini`:

    [uwsgi]

    master = true
    chdir = /srv/www/cookbook
    module = cookbook.wsgi:application
    env = DJANGO_SETTINGS_MODULE=cookbook.settings
    socket = /var/run/uwsgi/cookbook.socket
    daemonize = /var/log/uwsgi/cookbook.log
    logfile-chown = 1
    chmod-socket = 700
    chown-socket = www-data:www-data
    uid = www-data
    gid = www-data
    harakiri = 30
    processes = 1
    max-requests = 3


Assuming that the http server (such as [nginx][nginx]) runs as the
same `www-data` user the socket permissions can be 700. If you run the http
server and the uwsgi server as two different users you should use different
chmod for the socket to avoid permission problems.


[supervisord]: http://supervisord.org/
[the_arch_way]: https://wiki.archlinux.org/index.php/The_Arch_Way
[init_scripts]: http://refspecs.linuxbase.org/LSB_3.1.1/LSB-Core-generic/LSB-Core-generic/iniscrptact.html "Linux Standard Base Core Specification"
[nginx]: http://nginx.org/

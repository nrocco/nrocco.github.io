---
layout: post
title: Setup apache-mpm-itk for Symfony 2 development
comments: true
---

When developing on Symfony 2 applications you must have noticed that using the
cli `app/console` application messes up the file permissions of the cache and
logs folder. Especially when your apache webserver is running as e.g.
`www-data` (which is often the case and it is good practice too). 

<!-- more -->

By using apache-mpm-itk you can tell apache to serve/create files as if it was
running as that user.  The apache daemon process is still owned by and running
as `www-data`. 

A common practice is to configure your apache virtual host file to use the
UserId of your user. That way, all files generated in the `app/cache`
directory will always be owned by the same user. Then you do not have to worry
about setting umasks or applying world read/write permissions. 

### Install apache-mpm-itk

If you already have apache installed - do not worry - the following will
replace your current apache installation without overwriting your
configuration files.

    # Update your package list
    $ sudo apt-get update

    # Install apache-mpm-itk and restart it
    $ sudo apt-get install apache-mpm-itk
    $ sudo service apache2 restart


### Configure apache

Edit the virtual host file of your application:

    $ vim /etc/apache2/sites-available/your-vhost.conf

And include the following configuration (replace `username` and `groupname`
with your unix username and groupname):

    <IfModule mpm_itk_module>
      AssignUserId username groupname
    </IfModule>


Save the file and restart apache

    $ sudo service apache2 restart


Make sure you fix your application files permissions and ownership:

    $ cd /to/your/apps/folder
    $ chown -R user:group .
    $ chmod 755 app/cache app/log
    $ rm -rf app/cache/*
    $ php app/console cache:clear --env=dev

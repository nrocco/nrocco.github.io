---
layout: post
title: Doctrine 2 and MySQL 4.0
---

I ran into a problem when connecting to a MySQL database from a Symfony 2.0
project using Doctrine. 

<!-- more -->

The database I wanted to connect to was an older version: 4.0 and apparently
it does not support the `SET NAMES` SQL statement.

The following error was raised:

    Exception: SQLSTATE[HY000]: General error: 1193 Unknown system variable 'NAMES' (uncaught exception) at...

Doctrine 2 dispatches a onConnect event to execute this statement every time a
connection is made to a database. Unless you do not explicitly define a
charset for this MySQL connection.

By leaving the charset option blank in Symfony 2.0 configuration in
`app/config/config.yml` like this:

    dbal:
      default_connection:   default
      connections:
        default:
          driver:   %database_driver%
          host:     %database_host%
          port:     %database_port%
          dbname:   %database_name%
          user:     %database_user%
          password: %database_password%
          charset:


The Doctrine 2 onConnect event will not execute the `SET NAMES` statement.

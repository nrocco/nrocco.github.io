---
layout: post
title: Setup Postfix for development
---

The following tutorial shows how to setup a local postfix installation on a
ubuntu based OS that accepts mail from `127.0.0.1` and relays every mail that
it receives to the local root account.
This setup is very useful in e.g. a development environment if you are involved
in applications with send email functionality.

Optionally you can install mutt command line email client to read the email.

<!-- more -->

## Install Postfix

    $ apt-get install postfix
    $ dpkg-reconfigure postfix


Now we need to configure postfix to route all incoming email to the local root
account. During the previous step `dpkg-reconfigure postfix` you have
configured postfix to forward all mail for the local root user to another local
unix user.

    $ postconf -e 'home_mailbox = Maildir/'
    $ postconf -e 'inet_interfaces = 127.0.0.1'
    $ postconf -e 'virtual_alias_maps = regexp:/etc/postfix/virtual'
    $ postconf -e 'virtual_alias_domains ='
    $ echo '/.*/  root' > /etc/postfix/virtual
    $ postmap /etc/postfix/virtual
    $ service postfix restart


Most of the above configuration settings are taken from [this site][tipcache].
You can try sending an email using telnet like this (hit *enter* after every
line):

    $ telnet 127.0.0.1 25
    HELO some.server.localhost
    mail from: some_senders@email.address.com
    rcpt to: any_email_adress@willdo.com
    data
    To: any_email_adress@willdo.com
    From: some_senders@email.address.com
    Subject: This is a test email

    This is a body text
    .


You should see a lot of `250 2.x.x Ok` responses. Quit telnet and check the
logs if the email was received by the local postfix installation:

    $ tail /var/log/mail.log


## Installing mutt

If you follow these steps you will install [mutt][mutt], a command line email
client so you are able to read the messages that you are sending to yourself
:-).

    $ apt-get install mutt


We configured postfix to use the popular [Maildir][maildir] format instead of the
default [mbox][mbox] format. Maildir is better since it does not suffer of race
condition issues that mbox has because each email is stored in it's own file.

Create a file `.muttrc` in the users `$HOME` directory with the following
contents:

    $ cat ~/.muttrc 
    set folder="~/Maildir"
    set mask="!^\.[^.]"
    set mbox="~/Maildir"
    set record="+.Sent"
    set postponed="+.Drafts"
    set spoolfile="~/Maildir"


Now you should be able to open `mutt` and see the email you send yourself
earlier. Take your time to [explore and learn mutt][mutt_tutorial].



[tipcache]: http://www.tipcache.com/tip/Create_a_super_%22catch-all%22_email_address_in_Postfix_16.html
[mutt]: http://www.mutt.org
[maildir]: http://www.qmail.org/man/man5/maildir.html
[mbox]: http://www.qmail.org/qmail-manual-html/man5/mbox.html
[mutt_tutorial]: http://mutt.blackfish.org.uk

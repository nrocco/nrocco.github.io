---
layout: post
title: Actionscript 3 Datastructures
---

This morning I came across a [interesting AS3 implementation][dpkd] of the
common known data structures.  The download comes with a few interesting
classes that can be very helpful on Actionscript projects:
<!-- more -->
- A wrapper Class to store FlashVars to be used in a flash file (acts as a
  singleton).
- A Class to easy manage GET variables from a URL.
- A ResultSet Class for using data that is gathered with (for example) Flash
  Remoting.
- Remoting and Javascript Tracker Classes for easy tracking of user actions
  inside a flash application.
- A few Classes that make it easy to handle Flash Remoting calls.
- And some other classes to perform calculations on color values and
  manipulating Date and String objects.

I wasn't able to play with it yet. But as soon as I got a change I'll post my
experiences here. Especially integrating these data structures with PureMVC
applications.

[dpkd]: http://www.dpdk.nl/opensource/

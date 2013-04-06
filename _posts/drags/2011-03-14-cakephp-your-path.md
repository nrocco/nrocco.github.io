---
layout: post
title: CakePHP on your $PATH
---

Title:          CakePHP on your $PATH
Slug:           cakephp-your-path
Date:           2011-03-14 21:10:09
Tags:           php, development, framework, cakephp

I love baking a new project with the cake bake application from the terminal, especially with the new 2.0.0-dev version. 

Since I work on multiple CakePHP projects simultaneously I am also in favor of one shared CakePHP core.

To make baking easier we will create an alias in *~/.bash_profile* for our cake bake application so it saves us a lot of typing.
<!--more-->
When starting with an empty *webroot* directory, **bake** automatically does a few things for me:

- Copies a fresh app-skeleton to my webroot
- Automatically sets the absolute core path to where cake resides in *webroot/index.php* and *webroot/test.php*
- Creates a random hash key for your project (*Security.salt*)
- Creates a random seed for your project (*Security.cipherSeed*)


Let's assume we have the following directory structure:

- /Webserver/frameworks/cake/
- /Webserver/www/


The *www* folder is the root of our web server so that *http://localhost/* points to this directory.

In the */Webserver/frameworks/cake* folder you can place one centralized CakePHP core and thus share it among your applications. This setup is ideal for maintaining multiple core versions.

For example, in my /Webserver/frameworks/cake directory I have multiple directories called *1.3.7* and *2.0.0-dev* and so on for each cake core.

Now download the 2.0.0-dev version of CakePHP and extract its contents to */Webserver/frameworks/cake/2.0.0-dev/*. Make sure the *2.0.0-dev/* directory has the *core/* and *vendors/* directories. 

In the terminal edit your ~/.bash_profile by typing:

	# if you use TextMate
	mate ~/.bash_profile
	# or maybe use vi
	vi ~/.bash_profile

On a new line type the following:

	alias cake2="/Webserver/frameworks/cake/2.0.0-dev/cake/console/cake"
	
Notice that my alias is *cake2* so I know it uses the 2.0.0-dev version. I have another alias *cake1* that uses the 1.3.7 core library for baking.

You'll maybe use just one cake version, then set your alias name to just 'cake'.

And that's it!
To get started with a new project we create a fresh application like this:

	cd ~/Desktop
	mkdir newappname
	cd newappname
	cake2 bake project ./

This bakes a new CakePHP project in the *newappname* directory. In CakePHP 2.0.0-dev your newappname directory will contain all the files that used to live in the *app/* directory in older versions.

That's it!

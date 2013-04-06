---
layout: post
title: Let Flash use WordPress content
---

Last week I set up a fresh WordPress system for a client to function as a Content Managament System.
This week I am trying to load content that is managed and stored by WordPress in to a Flash front-end.

Currently our client has a Flash application running on the frontpage of his site which allow a user to browse content (that's also available as html) in an appealing way. Currently this Flash application gets it's content from a static .xml file.

But now that the new site [uses WordPress as a CMS tool][wp_as_cms_tool], it's time to rewrite this (static) Flash application so it loads categories and related posts from WordPress and display it in a more dynamic way.


*Goal*

Here is a quick list of things I want to achieve:

 - The Flash application outputs all categories (except for the standard 'Uncategorized' category)
 - For every category flash retrieves the five most recent posts (including custom key value pairs defined within WordPress)
 - The Flash application cycles through all the different categories and posts inside those categories, displaying photos and/or video which are defined by using the <a title="Custom Fields in WordPress" href="http://codex.wordpress.org/Using_Custom_Fields" target="_blank">Custom Fields</a> feature in WP.


*The Front-End*

For the front-end, this is how I set up my project:

 - A Actionscript 3.0 only project set up using Flex Builder 3.
 - Using Flash CS4 to create all my visual assets and export those as [SWC components][swc_components] so I can import them into my AS3 project.
 - The [PureMVC][puremvc_as3] framework for creating powerful, manageable applications.


*The Back-End*

Obviously for the back-end, in this case, I use WordPress. WordPress stores all it's content in a MySQL database.

 - [WordPress comes with an XML-RPC implementation][wp_xmlrpc_implementation] which allows you to display and manipulate content in a (custom made) client application through a set of PHP functions (API).

A Actionscript 3.0 implementation for XML-RPC is written by Daniel McLaren. [See here][xmlrpc_as3_libray]. He rewrote [Matt Shaw's][mattism] actionscript 2.0 implementation. Easy to set up and in now time you are sending and receiving xml messages from WordPress to use in your Flash application.


*Tim Wilsons PressConnect*

After playing a lot with the [XML-RPC][xmlrpc] functionality of WordPress itself, I discovered that, just like Tim Wilson said, it's quiet limited when it comes to displaying content.
XML-RPC focusses more on the content manipulation side. Creating and editting posts and categories.

I came across [PressConnect][press_connect], a simple php script for connection a Flash application to a WordPress blog.
Flash communicates with WordPress through PHP by talking in the XML language.
Actually, with PressConnect you bypass the WordPress engine and talk directly with the wp mysql database through php.

In the next update I'll try to show some screenshots and code snippets on how PressConnect works, also in comparison to the simple XML-RPC.

[mattism]:                  http://mattism.com/
[press_connect]:            http://www.tvwonline.net/lab/pressconnect/
[puremvc_as3]:              http://www.puremvc.org/
[swc_components]:           http://www.adobe.com/devnet/flash/articles/creating_as3_components.html
[wp_as_cms_tool]:           http://clicknathan.com/2006/11/07/how-to-use-wordpress-as-a-cms-content-management-system/ "WP XML-RPC API"
[wp_xmlrpc_implementation]: http://codex.wordpress.org/XML-RPC_wp
[xmlrpc]:                   http://www.xmlrpc.com/
[xmlrpc_as3_libray]:        http://danielmclaren.net/2007/08/03/xmlrpc-for-actionscript-30-free-library

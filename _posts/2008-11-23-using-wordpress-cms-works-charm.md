---
layout: post
title: Using Wordpress as a CMS works like a charm
---

This week i worked on a site development project for one of our clients. Basically the idea was to pimp their current site by implementing a Content Management system (CMS) on the back end.

Because I was very familiar with the WordPress system I knew it would be the perfect solution for this case. 
The WordPress Administration environment is so basic and straight forward that it becomes ideal to use it as a CMS tool for clients who don't have that much (online) knowledge.

Before I began I started drawing a hierarchal structure of the available content. So I could get a clear view on how to reuse the available WordPress functionalities. Here is what i found out:

- There are a few (approx. 10) static pages, obviously I will use the WordPress Pages to create and manage these static pages.
- There is one static page that needs to display a list of services the company offers. Every service comes with one or more sample projects.
- Every service the company offers will be managed through the WordPress Categories function. Where one category represents one service.
- The WordPress posts functionality will be used to create projects within each service (read: category).
- Then there is a list of partners and a list of press releases (short articles). I will use the Links functionality of WordPress to manage these two lists. 

After copying all the content from the old site in to WordPress (new site) I had to look at the current design and reuse it within my (yet to build) custom created WordPress Theme.

Getting a user account at [wordpress codex][codex] and searching a lot with google helped me with finding all the available template tags, functions and parameters to get the output I wanted, all within the powerful WordPress engine.

These articles on the web helped me during my development:

- [So you want to create wordpress themes huh][wpdesigner] Describes basic knowledge on how to set up a custom made theme. How you let WP know that a certain .php file is a template etc.
- [Wordpress Codex Main Page][codex_main] Use the function reference to see what tools you have available for outputting WP content in your WP template.


Plugins I used
--------------

- [Admin Management Extended Plugin][schloebe] Gives you a little more control in the WordPress admin environment, like ajax style dragging and dropping Pages to create a new order.
- [WP Extra Template Tags][tpl_tags] Gives you a few more simple php functions to play with in your templates.

And my number 1 tip is when you develop your custom templates and building a whole team. Make sure you use css, xhtml and javascript correctly. Test your whole site regularly against the [XHTML validator][html_w3c] and [CSS validator][css_w3c] from W3C.
Because I develop on a Mac in Safari, making sure everything I do is conform the W3C standards I wont get very much surprised when I open the page on a Windows computer in IE.

[codex]:       http://codex.wordpress.org/
[schloebe]:    http://www.schloebe.de/wordpress/admin-management-xtended-plugin/
[wpdesigner]:  http://www.wpdesigner.com/2007/02/19/so-you-want-to-create-wordpress-themes-huh/
[codex_main]:  http://codex.wordpress.org/Main_Page
[tpl_tags]:    http://www.web-templates.nu/2008/08/25/wp-extra-template-tags/
[html_w3c]:    http://validator.w3.org/
[css_w3c]:     http://jigsaw.w3.org/css-validator/

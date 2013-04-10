---
layout: post
title: A page filling slideshow html and javascript only
---

A while ago I started working on a idea to create a html only website with
window filling photos on the background that change just like a slideshow
does. Just like the kind of [sites you usually see][example] that are made in
Flash or Flex.

<!-- more -->

I looked around for possible solutions on Google and figured that I had to do
it myself. Now, based on the code of Scott Robin's Backstretch plugin I
created a small one-line-of-code jquery plugin that does just this.

You can download the plugin from github [here][github_link_to_plugin].

Preferably the plugin should work on all tablets as well.

### Information

A simple jquery plugin based on Scott Robin's jQuery Backstretch plugin.
Create a window filling slideshow in the background with multiple images.
Resizes images and maintains aspect ratio.

*Just one line of code*

Download the code from [github][github_link_to_plugin]

Check the [example][example] here

### Usage

Put this line of code in your html file:

	<script src="jquery-backgrounder.js"</script>
	<script>
	$(document).ready(function()
	{
	    var array_of_urls = [
	        "http://farm1.static.flickr.com/133/333784956_56749ca56c_b.jpg",
	        "http://farm1.static.flickr.com/141/333785078_72166a0c09_z.jpg?zz=1",
	        "http://farm1.static.flickr.com/147/333004440_f3889a07dc_z.jpg?zz=1"
	    ];

	    $.backgrounder( array_of_urls, options );
	});
	</script>

That's it.

### Options

There are a few options to configure the plugin to your needs.

	var options = {
	    transitionTime: 1600, // Amount of time to fade in/out the images.
	    displayTime: 5000, // For how long should a photo be displayed.
	    centeredX: true, // Should we center the image on the X axis?
	    centeredY: true, // Should we center the image on the Y axis?
	    zIndex: -666 // z-position of all the images.
	};


[example]: http://activeden.net/item/fullscreen-background-slideshow-v1/full_screen_preview/31303
[github_link_to_plugin]: https://github.com/nrocco/jquery-backgrounder

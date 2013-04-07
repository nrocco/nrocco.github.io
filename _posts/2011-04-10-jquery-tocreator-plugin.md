---
layout: post
title: JQuery Tocreator Plugin
---

**Minified version less then 1 kb!**

- *[Plugin homepage][plugin_homepage]*
- *[Plugin example][plugin_example]*
- *Version: 1.0.1*
- *Author: Nico Di Rocco*
- *(c) 2011 March Nico Di Rocco*

- - - 

jquery-tocreator is a simple jquery plugin allowing you to create a table of
contents on the fly based on a given css style selector.

### How It Works

Take, for example, a blog post that is wrapped inside an `<article>` tag. The
blog posts consists of a lot of text and has a few `<h3>` tags.
	
This plugin automatically assigns an id (based on the text of the heading) to
all the `<h3>` elements it finds inside the `<article>` tag.
	
	<h3>This is a heading</h3>

becomes

	<h3 id="this_is_a_heading">This is a heading</h3>

then a block level element is created (`<ul>` by default but you can override
this) and inserted in the DOM. This unordered list contains anchor style links
to the headings in the articles, formatted like this:

	<li><a href="#this_is_a_heading">This is a heading</a></li>


### Installation

	<script type="text/javascript" charset="utf-8" src="js/jquery.tocreator.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function()
		{
			$("article").tocreator();
		});
	</script>

### Configuration

The plugin has a few configuration options.

	// These are all default values and can be overridden
	var settings = {
		titleSelector: "h3",
		toc: null,
		tocPosition: "prepend",
		tocElementType: "ul",
		itemElementType: "li",
	};
	
	$("article").tocreator( settings );

- `titleSelector` | *String - default is "h3"*


	> The element to look for and on which the table of contents will be based.  
	This can be any string you would normally use as jquery selectors.



- `toc` | *Object - default is null*

	> If you don't want the plugin to create a table of contents container you can pass in a reference to your container and all the anchor links will be generated inside that. Examples are
		
	> `toc: $('div#toc')` or `toc: document.getElementById(#toc)`
	
	> If you assign a reference to the `toc` paramater then `tocPosition` and `tocElementType` will be ignored.



- `tocPosition` | *String - default is "prepend"*

	> If you want the plugin to create the toc container specify where you want it to be inserted in the DOM.  
	> Currently only *prepend* and *append* are possible values and these are relative to the article or post.  
	  


- `tocElementType` | *String - default is "ul"*

	> If you let the plugin create the content container specify the element type for the container here. For example: `div`, `ol` or `ul`  
	  
	
	
- `itemElementType` | *String - default is "li"*

	> Wrap the `<a>` anchor links inside the specified element.  
	> For example `li`, `span`, `strong`, `em`


[plugin_homepage]: http://casadirocco.nl/2011/04/10/jquery-tocreator-plugin/
[plugin_example]: http://content.casadirocco.nl/projects/jquery-tocreator/example.html

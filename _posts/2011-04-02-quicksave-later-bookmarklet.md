---
layout: post
title: Quicksave for later Bookmarklet
comments: true
---

This bookmarklet for Google Bookmarks allows you to ***quickly*** save a
webpage without opening a popup.  

<!-- more -->

***This is especially handy when working on the iPad*** where clicking on the
default Google bookmarklet opens up a new tab where you have to fill in a
form, hit submit, wait for the tab to auto close and then continue browsing.
With all the animations that take place, this can take up 30 seconds of your
time.  

This can be a tiring process, especially if you just want to (temporarily)
bookmark a page or maybe dozens of pages so you can come back to it later.  
  
If you are one of those people who casually serve the web and you find
something interesting but you don't want to dive into it now ***but*** you
quickly want to save the webpage as a bookmark than you will like this
*quicksave-forlater-bookmarklet*.

### Enough talking. How does it work?
1. Instead of opening the Google 'Add Bookmark' form in a popup, this
   bookmarklet opens the form in an iFrame that gets loaded on top of the
   website you are currently bookmarking.

2. As an added bonus, this bookmarklet scans the html document of the page you
   are bookmarking for the description and keywords `<meta />` tags and auto
   fills the 'Notes' textarea of the form.

3. It applies a default label `_SaveForLater_` to the bookmark.

4. The only thing you need to do is decide if you are happy the filled in data
   and hit *submit*.

5. Click or tap anywhere in the grey semi transparent background to close the
   iframe and continue browsing.

That's it!

### Cool. Now how can I use this?

Simple. Point your browser to [this page][bookmarklet_install].

- If you are installing the bookmarklet on your iphone or ipad, follow the
  instructions on that page.
- Otherwise, just drag the bookmarklet to your browsers bookmarks bar so you
  can access it quickly


[bookmarklet_install]: http://content.casadirocco.nl/projects/quicksave-forlater-bookmarklet/install.html

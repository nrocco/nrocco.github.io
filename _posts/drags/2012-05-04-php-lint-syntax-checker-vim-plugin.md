---
layout: post
title: PHP Lint syntax checker as a vim plugin
---

Title:          PHP Lint syntax checker as a vim plugin
Slug:           php-lint-syntax-checker-vim-plugin
Date:           2012-05-04 23:21:06
Tags:           vim, development, bash, shell, ide, php

I recently worked on a vim plugin that allows me to check the current PHP file I am editing for syntax errors.
If no errors are found it will print a status message on the screen. Otherwise, the vim quickfix window will popup allowing you to view all syntax erros and jump to that syntax error.
<!--more-->
By putting the following line in your ~/.vimrc you can check the current buffer by pressing `ctrl + l`.

    noremap <C-l> :Phplint<CR></CR>

You can download the plugin from github [here](http://github.com/nrocco/vim-phplint "Vim plugin to check php files for syntax errors")

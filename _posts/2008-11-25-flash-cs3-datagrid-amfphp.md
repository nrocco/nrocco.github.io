---
layout: post
title: Flash CS3 Datagrid with AMFPHP
comments: true
---

[Wade Arnold wrote an interesting article][wade_arnold] about connecting flash
to a MySql database with the help of AMFPHP, flash remoting.
<!-- more -->
Displaying the huge amount of information stored in a MySql database using the
DataGrid class that comes with Flash CS3. To fill a data grid in flash through
Flash Remoting, Wade points out that you need to write your own data provider
class to convert a AS3 Array Collection for the data grid. Strange enough this
data provider isn't part of Adobe Flash.

Here are some interesting sites to look on when you want to try AMFPHP and AS3
for yourself:

- [AMFPHP in Flash AS3 With AS][prodevtips]
- [AMFPHP 1.9 and AS3 Class Mapping][include_digital]
- [Hello AS3][flash_db]
- [Tutorials AS3 and AMFPHP roundup][flash_enabled]


[wade_arnold]: http://wadearnold.com/blog/?p=16
[prodevtips]: http://www.prodevtips.com/2008/07/28/amfphp-in-flash-cs3-with-as3-jquerypost-style/
[include_digital]: http://blog.include-digital.com/2008/05/22/amfphp-19-and-as3-class-mapping/
[flash_db]: http://www.flash-db.com/Tutorials/helloAS3/helloAS3.php?page=1
[flash_enabled]: http://flashenabledblog.com/2008/07/31/tutorials-as3-and-amfphp-roundup/

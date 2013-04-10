---
layout: post
title: Customizable ComboBox (Flash CS3)
---

Here is an example of how to customize the font (size, style, color) for the
[List][list] and [TextField][textfield] components inside a
[ComboBox][combobox]:

<!-- more -->

First you have to create a [TextFormat][textformat] object where you can
specify font, size and color parameters.

    var myTextFormat:TextFormat = new TextFormat();
    myTextFormat.font = "Comic Sans MS";
    myTextFormat.color = 0xFF0000;
    myTextFormat.size = 40;

Afterwards you create a new `ComboBox` and put it on the stage and assign the previous written `TextFormat` object to the textfield inside the ComboBox, like this:

    var myComboBox:ComboBox = new ComboBox();
    myComboBox.addItem( { label:"item1" } );
    myComboBox.addItem( { label:"item2" } );
    myComboBox.textField.setStyle("textFormat", myTextFormat);
    //myComboBox.dropdown.setRendererStyle("textFormat", myTextFormat2);
    addChild(myComboBox);

### Tips:

 - The instance name of the standard list component within a ComboBox is _dropdown_.
 - You can create another TextFormat object and assign this one to the `ComboBox.dropdown.setRendererStyle()` method within the ComboBox to format the font of the dropdown list. Instead of the `setStyle()` method (which the TextField uses) you have to use the `setRendererStyle()` method.
 - If you are adding items to a combobox using ActionScript 3.0: First addItems() to the ComboBox and afterwords set the style for the `ComboBox.dropdown` property. When you first set the style and addItems through actionscript later, somehow the style won't apply
 - The height and weight of the dropdown list does not auto scale when you set your font size bigger. If you, for example, want to increase the height of rows in the list, use the following code

    myComboBox.dropdown.rowHeight = 40;


[list]:         http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/fl/controls/List.html
[textfield]:    http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/text/TextField.html
[combobox]:     http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/fl/controls/ComboBox.html
[textformat]:   http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/text/TextFormat.html

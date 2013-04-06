---
layout: post
title: Importing Cinema4D model into Papervision3D 2.0
---

I would like to show you how you can use a custom polygon shape, made with Cinema 4D R11, using the build-in Collada export functionality in Papervision 3D 2.0 Great White.

- Watch the demo [here][demo]
- Download the AS source code [here][demo_source]
- The DAE file can be found over [here][demo_assets]

So, first of all we go into Cinema4D, I use version R11, because it has a Collada export functionality build in that can export to .dae files with the Collada 1.4.1 standard. Papervision knows how to handle these files.

### Cinema 4D R11

You will learn how to prepare your shape for Flash, re-order sub shapes into a hierarchy. Convert the whole thing in to triangular polygons and export the object as a .dae file.

- In Cinema4D I created a new basis primitive shape: a '*Figure*' ( Objects -> Primitives -> Figure ).
- Next, we need to make this basic shape editable so that it becomes an polygon object.
Do this by going to the Objects Manager > left click on the '*Figure*' object > and press 'C' on your keyboard.
- As shown in the picture above we can see that the shape is now editable since it has a triangular blue icon to the left of it. To the left of that icon we now can see a plus icon. Clicking on it will expand an hierarchy of editable shapes that ultimately make up the '*Figure*'.
- Now click on the plus sign next to the '*Upper Body*' polygon. Drag the '*Left Upper Arm*' and '*Right Upper Arm*' outside the whole '*Figure*' hierarchy by dragging them down to the empty space in the Object Manager.
- Now unfold all the objects that make the '*Right Upper Arm*' (as seen in the picture below), select them all by CMD+click or CTRL+click'ing on all of them. With all the polygons selected, right mouse click on one of them and choose '*Connect*' from the menu.
- This creates a new single polygon object called '*Right Upper Arm*' which you can see on the top of the list in your Objects Manager. No delete the original '*Right Upper Arm*' since we don't need that anymore. Repeat this proces with the '*Left Upper Arm*' and the '*Figure*' Hierarchy. Just make sure that you unfold every polygon by clicking on the <strong>\[+\]</strong> icon so you can select every single object in the hierarchy before 'Connecting them together.
- By this time you should end up with three single polygon objects (with no children). A Right Upper Arm, a 'Left Upper Arm' and a 'Figure'. Drag the the first two objects in to the latter. You should now end up with the same thing I have in the picture below.
- If we didn't make the left and right arm children of the figure object. In Flash they would become three separate DisplayObject3D objects in your scene, instead we want to make the left and right arm children of the figure so the left and right arm become separate DisplayObject3D objects inside the Figure DisplayObject3D object. Turning the Figure will keep the arms in place on the body where they should be.
- Go in to the front view by hitting F4 on your keyboard. Make sure you can see the whole figure. If you click on the 'Left Upper Arm' object, you can see that the center point of the left arm is in the middle of the figure. We need to move this center point to the left shoulder because in Flash we want to rotate the left arm but it needs to stay in the shoulder, otherwise it wouldn't be anatomically correct ;).
Go to Objects -> Object Axis in order to select the Object Axis tool and position the Axis at the shoulder just like me as you can see in the picture below. To the same for the right shoulder.
- No go back to the perspective view by hitting F1. In your Objects Manager select all the three polygons. If you can only see one named 'Figure' unfold it by clicking on the \[+\] icon next to it. Make sure you have all three polygons selected, go to Functions -> Triangulate.
Notice your figure in the perspective view. All square polygons became converted to triangular polygons. This is a very important step since objects in Papervision are also made up out of triangular shapes. Ignoring this step will cause Papervision to not recognize the imported shape!
- The last step in Cinema4D is exporting the figure object we created in to an Collada 1.4.1 .dae file. Do this by going to File -> Export -> Collada.
Save your file in the same folder where your .swf will be compiled to. If you would go in to the preferences of Cinema4D you will find out that there are some settings you can change regarding exporting to Collada. I left my settings to the default, they work just fine.
- Done. No let's go in to some ActionScript 3

### Flash ActionScript 3.0 ###

I have set up a basic ActionScript Only application called Cinema4D (in the file Cinema4D.as).
I have the latest Papervision 2.0 Great White framework checkout from SVN, [here][papervision].

I am not going in to detail on how to setup a basic Papervision scene in AS3 since that is not the scope of this tutorial. See my source code on how I set up my project, yours could differ but that not a problem. 
After i set up my viewport, camera, scene and basic render engine I do the following:
    
    var materials:MaterialsList = new MaterialsList();
    materials.addMaterial( new ColorMaterial( 16711935, 0.8, true ), "all" );

    dae = new DAE;
    dae.addEventListener( FileLoadEvent.LOAD_COMPLETE, myOnLoadCompleteHandler );
    dae.load( "figure.dae", materials );

    universe = new DisplayObject3D();
    universe.addChild( dae );
    scene.addChild( universe );

As you can see, I first make a material list and add one ColorMaterial with the name "all" so the material is applied to every object. Notice the third parameter I pass to the new `ColorMaterial()` which is set to 'true', meaning the material is interactive so it responds to mouse clicks et cetera.

Remember that you also pass the fourth argument as 'true' while initiating a new ViewPort3D. This will make the viewport interactive.

line 78 initiates a new DAE class instance which holds the functionality for loading an external .dae file.
Notice line 79. This one is import. When the .dae file finishes loading the myOnLoadCompleteHandler will be triggered. Line 80 to 84 aren't rocked science so I'll jump over to the event handler function I just mentioned.

    private function myOnLoadCompleteHandler( event:FileLoadEvent ) : void
    {
        var dae:DAE = event.target as DAE;
        var figure:DisplayObject3D = dae.getChildByName( "Figure", true );
			
        figure.scale = 2;
        figure.rotationY = 180;
			
        figure.addEventListener( InteractiveScene3DEvent.OBJECT_CLICK, onClick );
			
        leftArm = figure.getChildByName( "LeftArm", true );
        rightArm = figure.getChildByName( "RightArm", true );
			
        leftArm.rotationZ = 20;
        rightArm.rotationZ = -20;
    }
    
Since loading DAE files is an asynchronous process we have to wait till the `FileLoadEvent.LOAD_COMPLETE` event is triggered. Only then, and not a milli second sooner, are we able to 'browse' the hierarchy of `DisplayObject3D` objects inside the .dae.
As you can see in line 132 I access my `DisplayObject3D` by name, the name corresponds to the name we used in Cinema4D for the object.
Now we are able to do all sorts of things with the individual objects. No matter if they would be children of children of children, or the whole object itself. We can rotate them, move/rotate/scale them when your mouse cursor moves. Make the figure dance when we click a button, you name it.

ps; you may have noticed the `getChildByName()` in line 139 and 140 are using a different name as in the tutorial. This is because I changed the names of the left and right arm in Cinema4D and totally forgot the tell you about it. So you will use "Left Upper Arm" instead of "LeftArm" and "Right Upper Arm" instead of "RightArm".

Hope this tutorial helped.

[papervision]: http://code.google.com/p/papervision3d/source/checkout

[demo]: http://content.casadirocco.nl/papervision3d/import_from_cinema4d/
[demo_source]: http://content.casadirocco.nl/papervision3d/import_from_cinema4d/srcview/index.html
[demo_assets]: http://content.casadirocco.nl/papervision3d/import_from_cinema4d/figure.dae

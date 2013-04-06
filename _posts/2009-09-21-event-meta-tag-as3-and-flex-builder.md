---
layout: post
title: Event Meta Tag in AS3 and Flex Builder
---

Recently I found out about the `[Event]` meta tag in actionscript 3. 
I always thought it was a Flex-only meta tag but that isn't true.

Because many Flex components are coded in Actionscript only (for performance purposes) you can also use the `[Event]` meta tags in Actionscript only projects.
Since I am a big fan of code completion and strict typing everything in my code I am certainly adding the following trick to that list.

Consider you have a custom (abstract) Button Class called `UIButton` that dispatches custom events like `RELEASE`, `RELEASE_OUTSIDE`, `ON_ENABLED` et cetera. All those events are declared in a custom class called `UIButtonEvent` that extends the standard `MouseEvent` Class and has extra properties describing the button that fired the event.

In my `UIButtonEvent` Class I declared all static variables for the type names of my Events:

	public static const PRESS:String = ".onPress";
	public static const RELEASE:String = ".onRelease";
	public static const RELEASE_OUTSIDE:String = ".onReleaseOutside";

In my `UIButton` class I dispatch those Events:

	dispatchEvent( new UIButtonEvent( UIButtonEvent.RELEASE_OUTSIDE ) );

Now in the same `UIButton` Class, right below all the import statements and before the actual class definition i put these lines:

	[Event(name="release", type="nl.casadirocco.path.to.class.UIButtonEvent")]

The type attribute speaks for itself and points to the right package and Class where you have declared your custom Event class. Now the trick is the name attribute of the Event meta tag. This name needs to correspond with the static constant name declared in the UIButtonEvent class.

*	`[Event(name="release")]` corresponds with the static constant `RELEASE`

*	`[Event(name="releaseOutside")]` corresponds with the static constant `RELEASE_OUTSIDE`

*	`[Event(name="addedToStage")]` corresponds with the static constant `ADDED_TO_STAGE`

See how it works? Values in the name attribute of the Event meta tag should be Camel Cased and start with a lower-case letter. Every Uppercase letter is translated in to and underscore and thus creating static constant names like `RELEASE_OUTSIDE`

Now picture some view in where you have an instance of UIButton and you want to listen for the `RELEASE` event.

	var button:UIButton = new UIButton();
	button.addEventListener( UIButtonEvent.RELEASE, onButtonRelease );
	view.addChild( button );

In Flex Builder, as soon you type the last letters of the word "addEventListener" and then the bracket... a code completion window pops up. And because I used the Event meta tag in my UIButton Class, code completion now knows that the custom events from UIButtonEvent are associated with the UIButton and they will show up in code completion.

I started implementing this in all my custom components. Now when I am working on a project where I use some old component i build a few years ago, I instantly see what events I can listen for on that component and that tells me something about the workings of it without diving in to the actual code itself again.

Hope it helped (or will help) your workflow to.

---
layout: post
title: CakePHP 2.0.0-dev and Auth
---

Learn how to set up a authentication system in CakePHP 2.0.0-dev.  We are
going to use some basic validation for our models and set up the views.

See how the newest version of Cake makes your life easier when it comes to
authentication.

I spend a lot of time trying to figure out the right way to set up a simple
authentication system with CakePHP. A lot of documentation out there focusses
on old versions of Cake (mainly 1.2).

Since there are a few positive changes coming to version 2.0.0 that will make
authenticating users a lot more easier. I will focus on the differences
between older versions of CakePHP and the current 2.0.0-dev version.


###Assumptions
- You have a local web server and http://localhost/ points to a directory on
  your hard drive, say *~/www*.
- You located the CakePHP core directory outside your web server' www
  directory for safety.
- We are going to create a new project directly in the root of your localhost.


###Baking a Cake

Read my previous tutorial on how to set up a fresh CakePHP application the
2.0.0-dev way (<!-- TODO: insert link here -->).

Bake a new project:

    $ cd ~/www
    $ cake bake project ./

Just hit enter a few times to accept all default values.

Now create the following users table in your database.

    CREATE TABLE `users` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `created` datetime NOT NULL,
            `modified` datetime NOT NULL,
            `name` varchar(100) NOT NULL,
            `email` varchar(200) NOT NULL,
            `password` varchar(42) NOT NULL,
            PRIMARY KEY (`id`),
            UNIQUE KEY `email` (`email`)
    )

I made the email column unique. In this example we will log people in with an
email/password combination instead of a username.

Back to the terminal. Now with the cake console app we will create a database
configuration. Type the following command in your project root.

    $ cake bake

The console app recognizes that there isn't a database configuration present
for this project so you will have to create one now. There are lots of
tutorials out there on how to do this. Usually it involves hitting `<enter>` a
few times and filling in your username, password and database name.

Next we are going to set up an authentication system. The users controller
will handle user specific tasks like 'register' and 'forgot password' or
'delete my account'.  The sessions controller will handle session specific
tasks like logging in (create a session) and logging out (destroy a session).

Now type the following:

	$ cake bake model users
	$ cake bake controller users
	$ cake bake controller sessions

The first line creates a models/user.php file that has our User model.  The
next two commands create the files controllers/users\_controller.php and
controllers/sessions\_controller.php.  I am not baking views for these
controllers since we do not need the default views.

###Setting up the model

	<?php
	//
	// models/user.php
	//
	class User extends AppModel
	{
		var $displayField = 'name';

		var $validate = array(
			'name' => array(
				'name-not-empty-rule' => array('rule'=>'notEmpty','allowEmpty'=>false,'required'=>true)
			),
			'email' => array(
				'email'		=> array('rule'=>'email','allowEmpty'=>false,'required'=>true),
				'isUnique'	=> array('rule'=>'isUnique'),
				'notEmpty'	=> array('rule'=>'notEmpty')
			),
			'password' => array(
				'minLength'	=> array('rule'=>array('minLength',5),'allowEmpty'=>false,'required'=>true),
				'notEmpty'		=> array('rule'=>'notEmpty')
			),
			'password_confirm' => array(
				'comparePasswords'	=> array('rule'=>array('comparePasswords','password'),'allowEmpty'=>false,'required'=>true)
			)
		);
	
		// This method gets called when validating the virtual password_confirm field
		// If the values for password and password_confirm match, then return true
		// else it will return false.
		function comparePasswords( $field=array(), $compare_field=null )
		{
			foreach( $field as $key => $value )
			{ 
				$pass_1 = $value; 
				$pass_2 = $this->data[$this->name][ $compare_field ];                  
			
				if($pass_1 !== $pass_2) { 
						return false; 
				} else { 
					continue; 
				} 
			} 
			return true;
		}
	
		// This callback method gets called every time before a save operation starts.
		// By default CakePHP saves passwords unhashed in the database.
		// After all validation is succesful this method gets called and we substitute
		// the unhashed password (that the user filled in) with its hashed counterpart.
		// Eventually we return true otherwise the save operation fails.
		function beforeSave( $options = array() )
		{
			$password_unhashed = $this->data[$this->name]['password'];
			$this->data[$this->name]['password'] = AuthComponent::password( $password_unhashed );

			return true;
		}
	}
	?>

That's it. A simple User model with basic validation. We created a virtual
password\_confirm field with a custom validation rule that is defined in the
comparePasswords() method. Now, in the sign-up view we can add an extra input
field called password\_confirm and when the user submits the sign up form all
the validation is handled by the User model.  This way we avoid doing any
validation in the controller.

###Setting up the controllers

Lets add some functionality to all our controllers.  We start with the
AppController to set up the Auth component.

	//
	// app_controller.php
	//
	<?php
	class AppController extends Controller 
	{
		// We need the Auth component for our authentication system
		// And the Session component is needed for displaying flash messages.
		var $components = array('Auth','Session');
	
		// if a user is successfully logged in we store that user's record in this variable
		var $current_user = false;
	
		function beforeFilter()
		{
			// Specify which controller/action handles logging in:
			$this->Auth->loginAction = array('controller' => 'sessions', 'action' => 'create');
			// Where to redirect to after successfully logging in:
			// This can also be an array() with 'controller' and 'action' keys like above.
			$this->Auth->loginRedirect = '/';
			// Where to redirect to after successfully logging out:
			$this->Auth->logoutRedirect = '/';
		
			// By default, the Auth component expects a username and a password
			// columns in the User table. But we would like to override those defaults
			// and use the email column instead of the username column.
			$this->Auth->authenticate = array(
				AuthComponent::ALL => array(
					'fields' => array(
						'username' => 'email',
						'password' => 'password'),
					'userModel' => 'Users.User'
				), 'Form'
			);
		
			// store a reference to the current user
			$this->current_user = $this->Auth->user();
		}

		function beforeRender()
		{
			// Make the current_user variable available in all of our views
			// For example, in your view you can reach the current user's
			// email address as follows: echo $current_user['email'];
			$this->set('current_user',$this->current_user );
		}
	}
	?>

Then a few routes to create some pretty urls.

	<?php
	//
	// config/routes.php
	//	
	// Setup routes for the three essential actions that 
	// we need in order to create a basic authentication system.
	Router::connect('/login', array('controller' => 'sessions', 'action' => 'create'));
	Router::connect('/logout', array('controller' => 'sessions', 'action' => 'destroy'));
	Router::connect('/signup', array('controller' => 'users', 'action' => 'signup'));
	?>

Then the Session controller for logging in and logging out.

	<?php
	//
	// controllers/sessions_controller.php
	//
	class SessionsController extends AppController
	{
		// The SessionsController will use the User model
		var $uses = array("User");
	
		function beforeFilter()
		{
			parent::beforeFilter();
		
			// Tell the Auth controller that the 'create' action is accessible 
			// without being logged in.
			$this->Auth->allow('create');
		}

		public function create()
		{
			if ($this->request->is('post') )
			{
				if( $this->Auth->login() )
				{
					// the redirect() function in the Auth class redirects us
					// to the url we set up in the AppController.
					return $this->redirect( $this->Auth->redirect() );
				}
				else
				{
					$this->Session->setFlash(__('Email or password is incorrect',true));
				}
			}
		}

		public function destroy()
		{
			$this->Session->setFlash('Successfully logged out');
			// The following line redirects us to the page we set up in AppController
			// after being successfully logged out.
			$this->redirect( $this->Auth->logout() );
		}	
	}
	?>

Currently the User controller only handles signing up a new user.

	<?php
	//
	// controllers/users_controller.php
	//
	class UsersController extends AppController
	{
		function beforeFilter()
		{
			parent::beforeFilter();
			// Tell the Auth component that the sign-up action is accessible
			// without being logged in.
			$this->Auth->allow('signup');
		}

		public function signup()
		{
			if ($this->request->is('post'))
			{
				$this->User->create();

				if ($this->User->save($this->request->data))
				{
					$this->Session->setFlash(__('Your account has been created'));
					$this->Auth->login($this->request->data); // manually log in the user
					return $this->redirect($this->Auth->redirect()); // redirect
				} else
				{
					$this->Session->setFlash(__('Your newly created account could not be saved.'));
				}
			}
		}
	}
	?>


	<?php
	//
	// controllers/pages_controller.php
	//
	// Add this function to the Pages controller to allow users to see our app' landing page without being logged in
	function beforeFilter()
	{
		parent::beforeFilter();
		$this->Auth->allow('display');
	}
	?>


###Setting up the views

First the signup.ctp view so new users can register.  This view renders a sign
up form with the help of CakePHP Form Helper. As you can see here, I wrote the
different error messages for each field here in the view and pass them to
php's `__(string);` function so that localization is possible.

Every key you see in the *'error'* array corresponds with the keys we used for
the validators we set in the User model.

	<?php
	//
	// views/users/signup.ctp
	//
	echo $this->Form->create('User', array('action' => 'signup'));
	
		// As you can see I defined error messages in the view files instead of the User model.
		// I consider error messages as view logic. This way, everything that renders in the
		// view is in one place.
		echo $this->Form->input('name', array(
			'label' => __('Name', true),
			'error' => array(
				// here the key 'user-not-empty-rule' corresponds with the same key we defined in the User model
				// If the notEmpty rule for the 'name' in the User model returns false
				// this error message is shown
				'name-not-empty-rule'		=> __("Your name cannot be empty",true)
			)
		));
	
		echo $this->Form->input('email', array(
			'type' => 'email',
			'error' => array(
				'email'		=> __("This is not a valid email address",true),
				'isUnique'	=> __("There is already an account registered under this email address",true),
				'notEmpty'	=> __("You must fill in an email address",true)
			)
		));
	
		echo $this->Form->input('password', array(
			'error' => array(
				'notEmpty'		=> __("You must fill in a password",true),
				'minLength'	=> __("A password must be at least 5 characters long",true)
			)
		));
	
		echo $this->Form->input('password_confirm', array(
			'type'	=> 'password',
			'error'	=> array(
				'comparePasswords'	=> __("Your passwords do not match",true)
			)
		));
	
	echo $this->Form->end(__('Sign up',true));
	?>

Then the create.ctp view for logging in a user.
This view does nothing more then render out a login form.

	<?php
	//
	// views/sessions/create.ctp
	//
	// this creates a <form> opening tag for us that submits to the sessions/create action
	echo $this->Form->create('User', array(
		'url' => array('controller'=>'sessions','action' => 'create')
	));
	// create a <input> element for the email field
	echo $this->Form->input('email');
	// create a <input> element for the password field
	echo $this->Form->input('password');
	// create a closing <form> tag and a <input type="submit"> button
	echo $this->Form->end("Login");
	?>

And finally the home.ctp view, the landing page of the site.

	<?php
	//
	// views/pages/home.ctp
	//
	if( isset($current_user) ) { ?>
		
		<h1>Welcome <?php echo $current_user["name"]; ?><h1>
		<p>You are successfully logged in</p>
		<?php debug($current_user) ?>
		<p><?php echo $this->Html->link("Logout",array('controller'=>'sessions','action'=>'destroy')); ?></a>

	<?php } else { ?>

		<h1>Welcome</h1>
		<p>Click <?php echo $this->Html->link('here',array('controller'=>'sessions','action'=>'create')); ?> to login</p>
		<p>Or <?php echo $this->Html->link('here',array('controller'=>'users','action'=>'signup')); ?> to sign up</p>

	<?php } ?>

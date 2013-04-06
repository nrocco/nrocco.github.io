# Add existing user to existing auxillary group

    $ usermod -a -G groupname username


# Change existing user primary group

    $ usermod -g groupname username


# Removing A User

    # Find The User's Files
    $ find / -user username

	$ userdel --force --remove username


# Create a new user
	$ groupadd --gid 1001 user
	$ useradd -m --uid 1001 --gid 1001 -G audio,storage,video,wheel,games,power,scanner -s /bin/bash user
	$ passwd user
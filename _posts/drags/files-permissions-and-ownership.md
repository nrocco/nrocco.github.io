# Find all files recursively and correct permissions

	$ find . -type f -exec chmod 644 {} \;


# Find all directories recursively and correct permissions

	$ find . -type d -exec chmod 755 {} \;
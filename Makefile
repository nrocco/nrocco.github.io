help:
	@echo "Usage: make [html|server|clean]"
html:
	jekyll
server:
	jekyll serve --watch

clean:
	rm -rf _site/*

help:
	@echo Usage: make [html|server]
html:
	jekyll
server:
	jekyll --auto --server

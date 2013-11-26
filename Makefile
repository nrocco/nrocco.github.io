ICON=_images/coffee.svg

CONVERT=convert
CONVERT_OPTS=+antialias -transparent white

help:
	@echo "Usage: make [html|server|clean]"
html:
	jekyll build --drafts --baseurl ''
server:
	jekyll serve --watch --drafts --baseurl ''

clean:
	rm -rf _site/*

icons: favicon.ico favicon.png apple-touch-icon-precomposed.png apple-touch-icon-72x72-precomposed.png apple-touch-icon-114x114-precomposed.png apple-touch-icon-144x144-precomposed.png

favicon.ico: $(ICON)
	$(CONVERT) $< -bordercolor white -border 0 \
		\( -clone 0 -resize 16x16 \) \
		\( -clone 0 -resize 32x32 \) \
		\( -clone 0 -resize 48x48 \) \
		\( -clone 0 -resize 64x64 \) \
		-delete 0 $(CONVERT_OPTS) $@

favicon.png: $(ICON)
	$(CONVERT) $< -resize 32x32 $(CONVERT_OPTS) $@

apple-touch-icon-precomposed.png: $(ICON)
	$(CONVERT) $< -resize 57x57 $(CONVERT_OPTS) $@

apple-touch-icon-72x72-precomposed.png: $(ICON)
	$(CONVERT) $< -resize 72x72 $(CONVERT_OPTS) $@

apple-touch-icon-114x114-precomposed.png: $(ICON)
	$(CONVERT) $< -resize 114x114 $(CONVERT_OPTS) $@

apple-touch-icon-144x144-precomposed.png: $(ICON)
	$(CONVERT) $< -resize 144x144 $(CONVERT_OPTS) $@

clean_icons:
	rm -f favicon.ico favicon.png apple-touch-icon-precomposed.png apple-touch-icon-72x72-precomposed.png apple-touch-icon-114x114-precomposed.png apple-touch-icon-144x144-precomposed.png

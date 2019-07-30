PREFIX ?= /usr/local
PWD = $(shell pwd)
WP = wifi-pass

install:
	cp -f $(WP).sh $(PREFIX)/bin/$(WP) && chmod +x $(PREFIX)/bin/$(WP)

uninstall:
	rm -f $(PREFIX)/bin/$(WP)

reload:
	make uninstall && make

remove:
	rm -rf $(PWD)

trash:
	mv $(PWD) ~/.Trash/$(WP)
PREFIX ?= /usr/local

install:
	cp -f wifi-pass.sh $(PREFIX)/bin

uninstall:
	rm -f $(PREFIX)/bin/wifi-pass.sh
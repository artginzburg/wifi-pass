PREFIX ?= /usr/local

install:
	cp -f wifi-pass.sh $(PREFIX)/bin/wifi-pass && chmod +x $(PREFIX)/bin/wifi-pass

uninstall:
	rm -f $(PREFIX)/bin/wifi-pass

remove:
	rm -rf $(pwd) && cd
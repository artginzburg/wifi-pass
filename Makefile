PREFIX ?= /usr/local

install:
	cp -f wifi-pass.sh $(PREFIX)/bin && chmod +x /usr/local/bin/wifi-pass

uninstall:
	rm -f $(PREFIX)/bin/wifi-pass.sh
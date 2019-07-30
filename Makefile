PREFIX ?= /usr/local
PWD ?= $(shell pwd)
WP = wifi-pass

install:
	cp -f $(WP).sh $(PREFIX)/bin/$(WP) && chmod +x $(PREFIX)/bin/$(WP)

uninstall:
	rm -f $(PREFIX)/bin/$(WP)

reload:
	make uninstall && make

update:
	git clone --no-checkout https://github.com/DaFuqtor/$(WP) ~/$(WP)/$(WP).tmp && rm -rf ~/$(WP)/.git && mv ~/$(WP)/$(WP).tmp/.git ~/$(WP)/ && rmdir ~/$(WP)/$(WP).tmp && cd ~/$(WP) && git reset --hard HEAD

remove:
	rm -rf $(PWD)

trash:
	mv $(PWD) ~/.Trash/$(WP)
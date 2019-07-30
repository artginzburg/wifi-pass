PREFIX ?= /usr/local
PWD ?= $(shell pwd)
WP = wifi-pass

install:
	install -b $(WP).sh ${PREFIX}/bin/$(WP)

uninstall:
	rm -f $(PREFIX)/bin/$(WP) $(PREFIX)/bin/$(WP).old

update:
	git clone --no-checkout https://github.com/DaFuqtor/$(WP) ~/$(WP)/$(WP).tmp && rm -rf ~/$(WP)/.git && mv ~/$(WP)/$(WP).tmp/.git ~/$(WP)/ && rmdir ~/$(WP)/$(WP).tmp && cd ~/$(WP) && git reset --hard HEAD

upgrade:
	make update && make

remove:
	rm -rf $(PWD)

trash:
	mv $(PWD) ~/.Trash/$(WP)
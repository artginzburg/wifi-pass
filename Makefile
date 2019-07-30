PREFIX ?= /usr/local
PWD ?= $(shell pwd)
WP = wifi-pass

.PHONY: install all uninstall update upgrade remove

install:
	install -b $(WP).sh ${PREFIX}/bin/$(WP)

all:
	@echo "\nUsage: make [option]" \
        "\n                        \033[90m# Option left empty performs install\033[39m" \
	      "\n            uninstall   \033[90m# Removes the script\033[39m" \
	      "\n            update      \033[90m# Updates only the repo\033[39m" \
	      "\n            upgrade     \033[90m# Makes update & install\033[39m" \
	      "\n            remove      \033[90m# Moves to trash or deletes\n"

uninstall:
	rm -f $(PREFIX)/bin/$(WP) $(PREFIX)/bin/$(WP).old

update:
	git clone --no-checkout https://github.com/DaFuqtor/$(WP) ~/$(WP)/$(WP).tmp && rm -rf ~/$(WP)/.git && mv ~/$(WP)/$(WP).tmp/.git ~/$(WP)/ && rmdir ~/$(WP)/$(WP).tmp && cd ~/$(WP) && git reset --hard HEAD

upgrade:
	make update && make

remove:
	mv $(PWD) ~/.Trash/$(WP) || rm -rf $(PWD)
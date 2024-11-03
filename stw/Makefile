# stw - simple X text window
# See LICENSE file for copyright and license details.

include config.mk

all: stw

.c.o:
	$(CC) $(STWCFLAGS) -c $<

stw: stw.o
	$(CC) $^ $(STWLDFLAGS) -o $@

stw.o: arg.h config.h config.mk

clean:
	rm -f stw stw.o

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f stw $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stw
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < stw.1 > $(DESTDIR)$(MANPREFIX)/man1/stw.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/stw.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/stw \
		$(DESTDIR)$(MANPREFIX)/man1/stw.1

.PHONY: all clean install uninstall

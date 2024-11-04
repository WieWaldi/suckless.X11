# lsw - list window names
# See LICENSE file for copyright and license details.

include config.mk

SRC = lsw.c
OBJ = ${SRC:.c=.o}

all: options lsw

options:
	@echo lsw build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC -c $<
	@${CC} -c ${CFLAGS} $<

lsw: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f lsw ${OBJ} lsw-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p lsw-${VERSION}
	@cp -R LICENSE Makefile README config.mk lsw.1 ${SRC} lsw-${VERSION}
	@tar -cf lsw-${VERSION}.tar lsw-${VERSION}
	@gzip lsw-${VERSION}.tar
	@rm -rf lsw-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f lsw ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/lsw
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1/lsw.1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < lsw.1 > ${DESTDIR}${MANPREFIX}/man1/lsw.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/lsw.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/lsw
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/lsw.1

.PHONY: all options clean dist install uninstall

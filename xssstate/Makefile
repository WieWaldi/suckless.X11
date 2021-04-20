# See LICENSE file for copyright and license details.

include config.mk

SRC = xssstate.c
OBJ = ${SRC:.c=.o}

all: options xssstate

options:
	@echo xssstate build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

xssstate: xssstate.o
	@echo CC -o $@
	@${CC} -o $@ xssstate.o ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f xssstate ${OBJ} xssstate-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p xssstate-${VERSION}
	@cp -R LICENSE README Makefile config.mk xsidle.sh \
		xssstate.1 arg.h ${SRC} xssstate-${VERSION}
	@tar -cf xssstate-${VERSION}.tar xssstate-${VERSION}
	@gzip xssstate-${VERSION}.tar
	@rm -rf xssstate-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f xssstate ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/xssstate
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < xssstate.1 > ${DESTDIR}${MANPREFIX}/man1/xssstate.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/xssstate.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/xssstate
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/xssstate.1

.PHONY: all options clean dist install uninstall

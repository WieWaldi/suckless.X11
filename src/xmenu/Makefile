include config.mk

SRCS = ${PROG}.c
OBJS = ${SRCS:.c=.o}

all: ${PROG}

${PROG}: ${OBJS}
	${CC} -o $@ ${OBJS} ${LDFLAGS}

${OBJS}: config.h

.c.o:
	${CC} ${CFLAGS} -c $<

clean:
	-rm ${OBJS} ${PROG}

install: all
	install -D -m 755 ${PROG} ${DESTDIR}${PREFIX}/bin/${PROG}
	install -D -m 755 ${PROG}.sh ${DESTDIR}${PREFIX}/bin/${PROG}.sh
	install -D -m 644 ${PROG}.1 ${DESTDIR}${MANPREFIX}/man1/${PROG}.1
	install -D -m 644 icons/x-gimp.png ${DESTDIR}${PREFIX}/icons/hicolor/48x48/apps
	install -D -m 644 icons/x-web.png ${DESTDIR}${PREFIX}/icons/hicolor/48x48/apps

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/${PROG}
	rm -f ${DESTDIR}${PREFIX}/bin/${PROG}.sh
	rm -f ${DESTDIR}${PREFIX}/man1/${PROG}.1

.PHONY: all clean install uninstall

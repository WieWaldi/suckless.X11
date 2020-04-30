# rotwall
include config.mk

.PHONY: all options install uninstall

all: options

options:
	@echo "This build options:"
	@echo "PREFIX     = ${PREFIX}"
	@echo "MANPREFIX  = ${MANPREFIX}"

install:
	@echo "Installing executable file to ${PREFIX}/bin"
	@cp -f rotwall ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/rotwall
	@echo "Installing manual page to ${MANPREFIX}/rotwall.1"
	@sed "s/VERSION/${VERSION}/g" < rotwall.1 > ${MANPREFIX}/man1/rotwall.1
	@chmod 644 ${MANPREFIX}/man1/rotwall.1

uninstall:
	@echo "Removing executable file from ${PREFIX}/bin"
	@rm -f ${PREFIX}/bin/rotwall
	@echo "Removing manual page from ${MANPREFIX}/man1"
	@rm -f ${MANPREFIX}/man1/rotwall.1

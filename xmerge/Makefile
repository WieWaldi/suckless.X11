# xmerge
include config.mk

.PHONY: all options install uninstall

all: options

options:
	@echo "This build options:"
	@echo "PREFIX     = ${PREFIX}"
	@echo "MANPREFIX  = ${MANPREFIX}"

install:
	@echo "Installing executable file to ${PREFIX}/bin"
	@cp -f xmerge ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/xmerge
	@echo "Installing manual page to ${MANPREFIX}/xmerge.1"
	@sed "s/VERSION/${VERSION}/g" < xmerge.1 > ${MANPREFIX}/man1/xmerge.1
	@chmod 644 ${MANPREFIX}/man1/xmerge.1

uninstall:
	@echo "Removing executable file from ${PREFIX}/bin"
	@rm -f ${PREFIX}/bin/xmerge
	@echo "Removing manual page from ${MANPREFIX}/man1"
	@rm -f ${MANPREFIX}/man1/xmerge.1

clean:
	@echo "Nothing to do."

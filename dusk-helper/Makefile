# dwm-helper
include config.mk

.PHONY: all options install uninstall

all: options

options:
	@echo "This build options:"
	@echo "PREFIX     = ${PREFIX}"
	@echo "MANPREFIX  = ${MANPREFIX}"

install:
	@echo "Installing executable file to ${PREFIX}/bin"
	@mkdir -p ${PREFIX}/bin
	@mkdir -p ${PREFIX}/share/dusk
	@cp -f dusk-brightness ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-brightness
	@cp -f dusk-media ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-media
	@cp -f dusk-notetaking ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-notetaking
	@cp -f dusk-status ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-status
	@cp -f dusk-system ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-system
	@cp -f dusk-volumectrl ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-volumectrl
	@cp -f dusk-wrapper ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-wrapper
	@cp -f dusk-xsession ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dusk-xsession

uninstall:
	@echo "Removing executable file from ${PREFIX}/bin"
	@rm -f ${PREFIX}/bin/dusk-brightness
	@rm -f ${PREFIX}/bin/dusk-media
	@rm -f ${PREFIX}/bin/dusk-notetaking
	@rm -f ${PREFIX}/bin/dusk-status
	@rm -f ${PREFIX}/bin/dusk-system
	@rm -f ${PREFIX}/bin/dusk-volumectrl
	@rm -f ${PREFIX}/bin/dusk-wrapper
	@rm -f ${PREFIX}/bin/dusk-xsession

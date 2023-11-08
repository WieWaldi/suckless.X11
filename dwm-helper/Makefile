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
	@mkdir -p ${PREFIX}/share/dwm
	@cp -f dwm-brightness ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-brightness
	@cp -f dwm-media ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-media
	@cp -f dwm-notetaking ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-notetaking
	@cp -f dwm-status ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-status
	@cp -f dwm-system ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-system
	@cp -f dwm-volumectrl ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-volumectrl
	@cp -f dwm-wrapper ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-wrapper
	@cp -f dwm-xsession ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-xsession
	@cp -f dwm-layoutmenu ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/dwm-layoutmenu
	@cp -f autostart.sh ${PREFIX}/share/dwm
	@chmod 755 ${PREFIX}/share/dwm/autostart.sh
	@cp -f autostart_blocking.sh ${PREFIX}/share/dwm
	@chmod 755 ${PREFIX}/share/dwm/autostart_blocking.sh

uninstall:
	@echo "Removing executable file from ${PREFIX}/bin"
	@rm -f ${PREFIX}/bin/dwm-brightness
	@rm -f ${PREFIX}/bin/dwm-media
	@rm -f ${PREFIX}/bin/dwm-notetaking
	@rm -f ${PREFIX}/bin/dwm-status
	@rm -f ${PREFIX}/bin/dwm-system
	@rm -f ${PREFIX}/bin/dwm-volumectrl
	@rm -f ${PREFIX}/bin/dwm-wrapper
	@rm -f ${PREFIX}/bin/dwm-xsession
	@rm -f ${PREFIX}/bin/dwm-layoutmenu
	@rm -f ${PREFIX}/share/dwm/autostart.sh
	@rm -f ${PREFIX}/share/dwm/autostart_blocking.sh

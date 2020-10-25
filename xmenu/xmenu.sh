#!/bin/sh

cat <<EOF | xmenu | sh &
Internet
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-chrome.png					Google Chrome				/bin/google-chrome
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-thunderbird.png			Thunderbird					/bin/thunderbird
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-netflix.png				Netflix						/bin/google-chrome https://www.netflix.com
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-whatsapp.png				WhatsApp					${HOME}/.local/bin/surf web.whatsapp.com
Applications
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-alsamixer.png				Alsa Mixer					/bin/xterm -fa 'FiraMono Nerd Font' -fs 6 -e /bin/alsamixer
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-cava.png					Audio Visualizer			/bin/xterm -fa 'FiraMono Nerd Font' -fs 6 -e ${HOME}/.local/bin/cava
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-calc.png					Calculator					/bin/gnome-calculator
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-citrix.png					Citrix						${HOME}/.local/bin/citrix
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-deadbeef.png				DeadBeef					/bin/deadbeef
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-dragonplayer.png			DragonPlayer				/bin/dragon
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-thunar.png					File Manager				/bin/thunar
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-fontforge.png				FontForge					/bin/fontforge
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-freecad.png				FreeCad						${HOME}/.local/bin/freecad
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-gimp.png					Gimp						/bin/gimp
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-okular.png					Okular						/bin/okular
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-vmrc.png					VMware Remote Console		/bin/vmrc
Office
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-base.png		LibreOffice Base			/bin/libreoffice --base
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-calc.png		LibreOffice Calc			/bin/libreoffice --calc
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-draw.png		LibreOffice Draw			/bin/libreoffice --draw
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-impress.png	LibreOffice Impress			/bin/libreoffice --impress
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-main.png		LibreOffice Main			/bin/libreoffice
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-math.png		LibreOffice Math			/bin/libreoffice --math
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-writer.png		LibreOffice Writer			/bin/libreoffice --writer
System Application
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-compton.png				Compton (start)				/bin/dbus-launch ${HOME}/.local/bin/compton
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-compton.png				Compton (kill)				/bin/pkill compton
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-gear.png					X.org Client Properties		${HOME}/.local/bin/xclientprop.sh
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-xsensors.png				XSensors					/bin/xsensors

IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-xterm.png						Terminal (xterm)			/bin/xterm
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-st.png							Terminal (st)				${HOME}/.local/bin/st

IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-shutdown.png					Shutdown					/sbin/poweroff
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-reboot.png						Reboot						/sbin/reboot
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-logout.png						Logout						/bin/pkill -KILL -u $USER
EOF

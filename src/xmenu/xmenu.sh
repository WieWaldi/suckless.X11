#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | xmenu.sh                                                                   |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Wrapper script for xmenu                                      |
# |    Requires: ---                                                           |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 3                                                             |
# |     Created: 10.08.2022                                                    |
# |    Revision: ---                                                           |
# |                                                                            |
# | Copyright © 2022 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

cat <<EOF | xmenu | sh &
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-tasklist.png					Open File									${HOME}/.local/bin/xmenu-openfile.sh

Internet
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-chrome.png					Google Chrome								/bin/google-chrome
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-thunderbird.png			Thunderbird									/bin/thunderbird
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-netflix.png				Netflix										/bin/google-chrome https://www.netflix.com
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-whatsapp.png				WhatsApp									${HOME}/.local/bin/surf web.whatsapp.com
Applications
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-alsamixer.png				Alsa Mixer									/bin/xterm -fa 'FiraMono Nerd Font' -fs 6 -e /bin/alsamixer
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-cava.png					Audio Visualizer							/bin/xterm -fa 'FiraMono Nerd Font' -fs 6 -e /usr/bin/cava
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-calc.png					Calculator									/bin/gnome-calculator
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-st.png						CMatrix										${HOME}/.local/bin/cool-retro-term -p Vintage -T CMatrix -e cmatrix
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-citrix.png					Citrix										${HOME}/.local/bin/citrix
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-darktable.png				Darktable									/bin/darktable
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-deadbeef.png				DeadBeef									/bin/deadbeef
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-dragonplayer.png			DragonPlayer								/bin/dragon
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-thunar.png					File Manager								/bin/thunar
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-fontforge.png				FontForge									/bin/fontforge
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-freecad.png				FreeCad										${HOME}/.local/bin/freecad
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-gimp.png					Gimp										/bin/gimp
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-hugin.png					Hugin										/bin/hugin
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-luminance-hdr.png			Luminance									/usr/bin/luminance-hdr
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-okular.png					Okular										/bin/okular
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-veracrypt.png				Veracrypt									/usr/bin/veracrypt
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-vmrc.png					VMware Remote Console						/bin/vmrc
Office
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-base.png		LibreOffice Base							/bin/libreoffice --base
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-calc.png		LibreOffice Calc							/bin/libreoffice --calc
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-draw.png		LibreOffice Draw							/bin/libreoffice --draw
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-impress.png	LibreOffice Impress							/bin/libreoffice --impress
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-main.png		LibreOffice Main							/bin/libreoffice
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-math.png		LibreOffice Math							/bin/libreoffice --math
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-libreoffice-writer.png		LibreOffice Writer							/bin/libreoffice --writer
System Application
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-gear.png					Arandr										/usr/bin/arandr
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-compton.png				Picom - Start (distro)						/usr/bin/picom --experimental-backends
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-compton.png				Picom - Start (suckless.X11)				${HOME}/.local/bin/picom
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-compton.png				Picom - Kill								/bin/pkill picom
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-gear.png					X.org Client Properties						${HOME}/.local/bin/xclientprop
	IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-xsensors.png				XSensors									/bin/xsensors

IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-thunar.png						File Manager (Thunar)						/bin/thunar
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-4Pane.png						File Manager (4Pane)						/bin/4Pane
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-file-manager.png				File Manager (Xfe)							/bin/xfe-xfe

IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-xterm.png						Terminal (xterm)							/bin/xterm
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-xterm.png						Terminal/Login (xterm)						/bin/xterm -ls
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-xterm.png						Terminal-Test/Login (xterm)					/bin/xterm -class XTerm-Test -ls
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-st.png							Terminal (st)								${HOME}/.local/bin/st
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-st.png							Terminal/Login (st)							${HOME}/.local/bin/st -e zsh --login

IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-calendar.png					Show Calendar (xmessage)					/bin/cal -m -n 3 | /bin/xmessage -default okay -file -
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-calendar.png					Show Calendar (gxmessage)					/bin/cal -m -n 3 | zenity --text-info --title="Calendar -- $(date "+%A %d.%m.%Y")" --font="monospace 16" --height=500 --width=1000

IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-shutdown.png					Shutdown									/sbin/poweroff
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-reboot.png						Reboot										/sbin/reboot
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-logout.png						Logout										/bin/pkill -KILL -u $USER
IMG:${HOME}/.local/share/icons/hicolor/48x48/apps/rz-logout.png						Logout 2									/bin/killall dwm
EOF

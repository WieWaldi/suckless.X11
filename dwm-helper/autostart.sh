#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | autostart.sh (for dwm)                                                     |
# +----------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Autostart ------------------------------------------------------------+
# /bin/xsetroot -fg black -bg white -bitmap /usr/include/X11/bitmaps/root_weave


/usr/local/bin/dunst & > /dev/null 2>&1 &
${HOME}/.local/bin/xclickroot -r ${HOME}/.local/bin/xmenu.sh &
/bin/dbus-launch /bin/picom --experimental-backends &
${HOME}/.local/bin/dwm-status &
${HOME}/.local/bin/rotwall ${HOME}/.local/share/wallpapers 300 &

${HOME}/.local/bin/st &
${HOME}/.local/bin/st -e ${HOME}/.local/bin/tmux-start.sh Login &

# /usr/bin/oneko -name "oneko" -tofocus -sakura -bg pink -speed 32 -time 75000 &
/bin/google-chrome &

/usr/bin/amixer -q -D pulse sset Master 45% &
/bin/mplayer ~/.local/share/sounds/Windows/Windows95_Login.ogg > /dev/null 2>&1

exit 0

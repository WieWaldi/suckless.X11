#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | autostart.sh (for dwm)                                                  |
# +-------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+


# Start my stuff
# ---------------------------------------------------------------------------
/usr/local/bin/dunst & > /dev/null 2>&1 &
amixer -q -D pulse sset Master 25%
${HOME}/.local/bin/xclickroot -r ${HOME}/.local/bin/xmenu.sh &
/bin/dbus-launch ${HOME}/.local/bin/compton &
${HOME}/.local/bin/dwm-status &
${HOME}/.local/bin/rotwall ${HOME}/.local/share/wallpapers 300 &

${HOME}/.local/bin/st &
${HOME}/.local/bin/st &

exit 0

#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | ~/.local/bin/autostart.sh (for dwm)                                        |
# +----------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Start Dunst Notification ---------------------------------------------+
/usr/bin/dunst & > /dev/null 2>&1 &

# +----- Start xclickroot to support xmenu ------------------------------------+
${HOME}/.local/bin/xclickroot -r ${HOME}/.local/bin/xmenu.sh &

# +----- Start picom-----------------------------------------------------------+
${HOME}/.local/bin/picom &

# +----- Start dwm-status -----------------------------------------------------+
${HOME}/.local/bin/dwm-status &

# +----- Set wallpaer ---------------------------------------------------------+
# /bin/xsetroot -fg black -bg white -bitmap /usr/include/X11/bitmaps/root_weave
${HOME}/.local/bin/rotwall ${HOME}/.local/share/wallpapers 300 &

# +----- Start st terminal with tmux login session ----------------------------+
${HOME}/.local/bin/st -e ${HOME}/.local/bin/tmux-start.sh Login &

# +----- Start Oneko showing Sakura -------------------------------------------+
# /usr/bin/oneko -name "oneko" -tofocus -sakura -bg pink -speed 32 -time 75000 &

# +----- Start Google Chrome --------------------------------------------------+
# /bin/google-chrome &

# +----- Play Windows Startup Sound -------------------------------------------+
# /usr/bin/amixer -q -D pulse sset Master 45% &
# /bin/mplayer ~/.local/share/sounds/Windows/Windows95_Login.ogg & > /dev/null 2>&1

# +----- Mouse Settings -------------------------------------------------------+
# /usr/bin/xinput --set-prop 12 'libinput Accel Profile Enabled' 0 0 0
# /usr/bin/xinput --set-prop 12 'libinput Accel Speed' -0.25

# +----- End ------------------------------------------------------------------+
exit 0

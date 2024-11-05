#!/bin/sh
#
# +-------------------------------------------------------------------------+
# | .xinitrc                                                                |
# +-------------------------------------------------------------------------+
# | Copyright (C) 2019 Waldemar Schroeer                                    |
# |                    lassmichinruhe@rz-amper.de                           |
# +-------------------------------------------------------------------------+

# General X11 related stuff
# ---------------------------------------------------------------------------
[[ -f ${HOME}/.Xresources ]] && xrdb -merge -I$HOME ${HOME}/.Xresources
# /bin/xsetroot -fg black -bg white -bitmap /usr/include/X11/bitmaps/root_weave
# /bin/xrandr --output Virtual-1 --mode 1912x980
# /bin/xrandr --output Virtual-1 --mode 1920x1080
# /bin/xrandr --output Virtual-1 --mode 1440x900
# /bin/xrandr --output DVI-D-1 --rotate left
# /bin/xrandr --output DVI-I-0 --mode 848x480

/bin/xset +fp ${HOME}/.local/share/fonts
/bin/xset fp rehash
/bin/xset -b # disable bell
/bin/xset s off
/bin/xset -dpms

# Set my background
# ---------------------------------------------------------------------------
${HOME}/.local/bin/feh --bg-scale ${HOME}/.local/share/wallpapers/1920x1080_HotDog.jpg

# Start notification service
# ---------------------------------------------------------------------------
/usr/local/bin/dunst & > /dev/null 2>&1 &

# Start my stuff
# ---------------------------------------------------------------------------
amixer -q -D pulse sset Master 25%
# /bin/amixer -q sset 'Master' 25%
# ${HOME}/.local/bin/xclickroot -r ${HOME}/.local/bin/xmenu.sh &
${HOME}/.local/bin/compton &
${HOME}/.local/bin/st &
${HOME}/.local/bin/st &
/bin/xeyes &
/bin/xclock &

# Start window manager
# ---------------------------------------------------------------------------
${HOME}/.local/bin/dwm_status &
${HOME}/.local/bin/rotwall ${HOME}/.local/share/wallpapers 300 &
exec ${HOME}/.local/bin/dwm 2> ${HOME}/tmp/dwm.log

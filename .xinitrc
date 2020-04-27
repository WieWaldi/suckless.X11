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
# /bin/xrandr --output DP-3 --rotate left
# /bin/xset +fp ${HOME}/.local/share/fonts
# /bin/xset fp rehash
# /bin/xset -b # disable bell
# /bin/xset s off
# /bin/xset -dpms

# Set my background
# ---------------------------------------------------------------------------
# ${HOME}/.local/bin/feh --bg-scale ${HOME}/.local/share/background/funeral.jpg &
${HOME}/.local/bin/feh --bg-scale ${HOME}/.local/share/background/HotDog.jpg &

# Start notification service
# ---------------------------------------------------------------------------
/usr/local/bin/dunst & > /dev/null 2>&1 &


# Start my stuff
# ---------------------------------------------------------------------------
# ${HOME}/.local/bin/compton &
# ${HOME}/.local/bin/tabbed -r 2 ${HOME}/.local/bin/st -w '' &
${HOME}/.local/bin/st -e /bin/htop &
${HOME}/.local/bin/st &
${HOME}/.local/bin/st &


# Start window manager
# ---------------------------------------------------------------------------
${HOME}/.local/bin/dwm_status &
exec ${HOME}/.local/bin/dwm 2> ${HOME}/tmp/dwm.log

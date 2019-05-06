#!/bin/sh
#
# +-------------------------------------------------------------------------+
# | .xinitrc                                                                |
# +-------------------------------------------------------------------------+
# | Copyright (C) 2019 Waldemar Schroeer                                    |
# |                    lassmichinruhe@rz-amper.de                           |
# +-------------------------------------------------------------------------+

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

/bin/xsetroot -fg black -bg white -bitmap /usr/include/X11/bitmaps/root_weave
# /bin/xrandr --output Virtual-1 --mode 1440x900
# /bin/xset +fp ~/.fonts
# /bin/xset fp rehash
# /bin/xset -b # disable bell
# /bin/xset s off

~/bin/dwm_status &
exec ~/bin/dwm 2> ~/tmp/dwm.log

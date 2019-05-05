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
/bin/xrandr --output Virtual-1 --mode 1680x1050
/bin/xterm &

exec ~/bin/dwm

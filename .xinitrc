#!/bin/sh
#
# +-------------------------------------------------------------------------+
# | .xinitrc                                                                |
# +-------------------------------------------------------------------------+
# | Copyright (C) 2019 Waldemar Schroeer                                    |
# |                    lassmichinruhe@rz-amper.de                           |
# +-------------------------------------------------------------------------+

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# /bin/xsetroot -fg black -bg white -bitmap /usr/include/X11/bitmaps/root_weave

# /bin/xrandr --output Virtual-1 --mode 1440x900
# /bin/xrandr --output DP-3 --rotate left

# /bin/xset +fp ~/.local/share/fonts
# /bin/xset fp rehash
# /bin/xset -b # disable bell
# /bin/xset s off
# /bin/xset -dpms

# ~/bin/st -e ~/bin/htop &
# ~/bin/tabbed xterm -into &
~/.local/bin/feh --bg-scale ~/.local/share/background/funeral.jpg &
~/.local/bin/compton &
~/.local/bin/tabbed -r 2 ~/.local/bin/st -w '' &

~/.local/bin/dwm_status &
exec ~/.local/bin/dwm 2> ~/tmp/dwm.log

<img src="https://raw.githubusercontent.com/WieWaldi/suckless.X11/master/img/RZ-Amper_Logo_135x135.png" align="left" width="135px" height="135px" />

### dwm
> *My personal build of dwm.*

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

<br />

# dwm - dynamic window manager
dwm is an extremely fast, small, and dynamic window manager for X.


## Requirements
In order to build dwm you need the Xlib header files.


## Installation
Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm (if
necessary as root):

    make clean install


## Running dwm
Add the following line to your .xinitrc to start dwm using startx:

    exec dwm

In order to connect dwm to a specific display, make sure that
the DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec dwm

(This will start dwm on display :1 of the host foo.bar.)

In order to display status info in the bar, you can do something
like this in your .xinitrc:

    while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    do
    	sleep 1
    done &
    exec dwm


## Configuration
The configuration of dwm is done by creating a custom config.h
and (re)compiling the source code.

## Patches
The following patches have been applied.
 - dwm-cfacts-vanitygaps-6.2_combo.diff
 - dwm-autostart-20210120-cb3f58a.diff
 - dwm-xresources-20210827-138b405.diff
 - dwm-autostart-20210120-cb3f58a.diff
 - dwm-center-6.2.diff
 - dwm-colorbar-6.3.diff
 - dwm-movestack-20211115-a786211.diff
 - dwm-namedscratchpads-6.2.diff
 - dwm-pertag-20200914-61bb8b2.diff
 - dwm-status2d-6.3.diff
 - dwm-status2d-xrdb-6.2.diff

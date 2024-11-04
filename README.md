<img src="https://raw.githubusercontent.com/WieWaldi/suckless.X11/master/img/RZ-Amper_Logo_135x135.png" align="left" width="135px" height="135px" />

### suckless.X11 by WieWaldi
> *My personal build of dwm and other tools to form a suckless X11 environment.*

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

<br />

# suckless.X11
WieWaldi's collection of suckless applications and other simple tools adapted to
a minimal installation of CentOS. Yes, the name of this repository may be kinda
missleading since it doesn't contain suckless implementations only but other
stuff as well. This repo targets specially and only a minimal installation of
CentOS 7/8.

![screenshot](https://raw.githubusercontent.com/WieWaldi/suckless.X11/master/img/screenshot.jpg)

## Motivation ...
... is to get a CentOS minimal installation equiped with a suckless graphical
user interface in pretty much no time and hassle using a script for building
and installation.
I'm convinced that RedHatEL/CentOS is one of the best GNU/Linux distributions
and very well suited for company and business use. In my case, I'm running many
RedHatEL/CentOS servers at the back office and on some workstations as well.
I'm running security and data integrity tools for monitoring and alerting on
file & directory changes on all of my servers and workstations. The alarm bells
go off every time something gets changed besides the home directory. Hence I'm
installing most of these applications in my home directory.

## Requirements
A minimal installation of CentOS 8/7. All needed repositories and packages will
get installed during preparation. Don't forget to update your system right after
installation.

## Installation
Installation is split up in two parts. First you have to run the preparation
script as root. This will prepare your system by adding needed repositories and
packages and copying configuration files. During the preparation you will be
asked if you want to have the Google Chrome and VirtualBox repository added.

Then you log in with your user account at the console and run the setup script.
This will compile and install a bunch of applications. 

At that point I suggest to install my [.dotfiles](https://github.com/WieWaldi/.dotfiles)
as well.

Just to make that clear. You don't have to use the setup script. You may walk
through all sub directories and pick what you want to build and install.

To get slock/gllock working you have to set uid correctly.
```
sudo chown root:root ~/.local/bin/slock
sudo chmod u+s ~/.local/bin/slock
sudo chown root:root ~/.local/bin/gllock
sudo chmod u+s ~/.local/bin/gllock
```

Use the following command to simplify cloning the repository.
```
curl -s https://raw.githubusercontent.com/WieWaldi/suckless.X11/master/bootstrap.sh | bash
```

## Contents
This repository cotains the folloing applications. For convenience most of the
suckless.org applications have been patched already.
- **[dmenu](https://tools.suckless.org/dmenu/)** - dynamic menu (Version 5.0) contains the following patches.
  - [dmenu-borderoption-20200217-bf60a1e.diff](https://tools.suckless.org/dmenu/patches/border/)
  - [dmenu-center-20200111-8cd37e1.diff](https://tools.suckless.org/dmenu/patches/center/)
  - [dmenu-mousesupport-5.0.diff](https://tools.suckless.org/dmenu/patches/mouse-support/)
  - [dmenu-mousesupporthoverbgcol-5.0.diff](https://tools.suckless.org/dmenu/patches/mouse-support/)
  - [dmenu-numbers-4.9.diff](https://tools.suckless.org/dmenu/patches/numbers/)
  - [dmenu-xresources-4.9.diff](https://tools.suckless.org/dmenu/patches/xresources/)
- **[dwm](https://dwm.suckless.org/)** - dynamic window manager (Version 6.5, 2024-10-05) contains the following patches.
  - [dwm-autostart-20210120-cb3f58a.diff](https://dwm.suckless.org/patches/autostart/)
  - [dwm-center-6.3.diff](https://github.com/bakkeby/patches/blob/master/dwm/dwm-center-6.3.diff)
  - [dwm-cfacts-vanitygaps-6.5_full.diff](https://github.com/bakkeby/patches/blob/master/dwm/dwm-cfacts-vanitygaps-6.5_full.diff)
  - [dwm-cfacts-dragfact-6.5_full.diff](https://github.com/bakkeby/patches/blob/master/dwm/dwm-cfacts-dragfact-6.5_full.diff)
  - [dwm-colorbar-6.3.diff](https://dwm.suckless.org/patches/colorbar/)
  - [dwm-focusedontop-6.5.diff](https://github.com/bakkeby/patches/blob/master/dwm/dwm-focusedontop-6.5.diff)
  - [dwm-focusonclick-20200110-61bb8b2.diff](https://dwm.suckless.org/patches/focusonclick/)
  - [dwm-fullscreen-compilation-rule-6.3_full.diff](https://github.com/bakkeby/patches/blob/master/dwm/dwm-fullscreen-compilation-rule-6.3_full.diff)
  - [dwm-layoutmenu-6.2.diff](https://dwm.suckless.org/patches/layoutmenu/)
  - [dwm-movestack-20211115-a786211.diff](https://dwm.suckless.org/patches/movestack/)
  - [dwm-namedscratchpads-6.2.diff](https://dwm.suckless.org/patches/namedscratchpads/)
  - [dwm-netclientliststacking-6.5.diff](https://github.com/bakkeby/patches/blob/master/dwm/dwm-netclientliststacking-6.5.diff)
  - [dwm-pertag-6.5.diff](https://github.com/bakkeby/patches/blob/master/dwm/dwm-pertag-6.5.diff)
  - [dwm-statuscmd-nosignal-20210402-67d76bd.diff](https://dwm.suckless.org/patches/statuscmd/)
  - [dwm-resizecorners-6.5.diff](https://dwm.suckless.org/patches/resizecorners/)
  - [dwm-status2d-6.3.diff](https://dwm.suckless.org/patches/status2d/)
- **[dwm-helper](https://github.com/WieWaldi/suckless.X11/tree/master/dwm-helper)** - A collection of wrapper and helper scripts for dwm.
- **[farbfeld](https://tools.suckless.org/farbfeld/)** - A lossless image format which is easy to parse, pipe and compress.
- **[feh](https://github.com/derf/feh)** — Image Viewer and Cataloguer (Release v3.10.3)
- **[gllock](https://github.com/WieWaldi/suckless.X11/tree/master/gllock)** OpenGL extension to the simple screen locker slock.
- **[lsw](https://tools.suckless.org/x/lsw/)** - Lists the titles of all running X windows to stdout (lsw-0.3 (20141129))
- **[maim](https://github.com/naelstrof/maim)** - Make Image (v5.7.4)
- **[rotwall](https://github.com/WieWaldi/suckless.X11/tree/master/rotwall)** - rotate wallpapers.
- **[sent](https://tools.suckless.org/sent/)** - Simple plaintext presentation tool. (sent-1 (20170904))
  - [sent-invertedcolors-72d33d4.diff](https://tools.suckless.org/sent/patches/inverted-colors/)
  - [sent-toggle-scm-20210119-2be4210.diff](https://tools.suckless.org/sent/patches/toggle-scm/)
  - [sent-options-20190213-72d33d4.diff](https://tools.suckless.org/sent/patches/toggle-scm/)
- **[slock](https://tools.suckless.org/slock/)** — simple X screen locker (Version 1.4) contains the following patches.
  - [slock-capscolor-20170106-2d2a21a.diff](https://tools.suckless.org/slock/patches/capscolor/)
  - [slock-colormessage-20200210-35633d4.diff](https://tools.suckless.org/slock/patches/colormessage/)
  - [slock-xresources-20191126-53e56c7.diff](https://tools.suckless.org/slock/patches/xresources/)
- **[slop](https://github.com/naelstrof/slop)** - select operation
- **[sselp](https://tools.suckless.org/x/sselp/)** - Simple X selection printer.
- **[st](https://st.suckless.org/)** - simple terminal (Version 0.8.4) contains the following patches.
  - [st-alpha-0.8.2.diff](https://st.suckless.org/patches/alpha/)
    - [ST+alpha patch renders background brighter than other programs.](https://www.reddit.com/r/suckless/comments/zbrple/stalpha_patch_renders_background_brighter_than/)
    - [st with alpha patch looks awful while using solarized light theme](https://www.reddit.com/r/suckless/comments/170d1yl/st_with_alpha_patch_looks_awful_while_using/)
  - [st-blinking_cursor-20200531-a2a7044.diff](https://st.suckless.org/patches/blinking_cursor/)
  - [st-bold-is-not-bright-20190127-3be4cf1.diff](https://st.suckless.org/patches/bold-is-not-bright/)
  - [st-boxdraw_v2-0.8.3.diff](https://st.suckless.org/patches/boxdraw/)
  - [st-focus-20230610-68d1ad9.diff](https://st.suckless.org/patches/alpha_focus_highlight/)
  - [st-iso14755-0.8.3.diff](https://st.suckless.org/patches/iso14755/)
  - [st-scrollback-20200419-72e3f6c.diff](https://st.suckless.org/patches/scrollback/)
  - [st-scrollback-mouse-20191024-a2c479c.diff](https://st.suckless.org/patches/scrollback/)
  - [st-xresources-20200604-9ba7ecf.diff](https://st.suckless.org/patches/xresources/)
- **[stw](https://github.com/sineemore/stw)** - a simple text window for X.
- **[surf](https://surf.suckless.org/)** - simple webkit-based browser (Version 2.0) contains the following patches.
  - [surf-bookmarks-20170722-723ff26.diff](https://surf.suckless.org/patches/bookmarking/)
  - [surf-dlconsole-20190919-d068a38.diff](https://surf.suckless.org/patches/dlconsole/)
  - [surf-git-20170323-webkit2-searchengines.diff](https://surf.suckless.org/patches/dlconsole/)
  - [surf-notifications-20201223-7dcce9e1.diff](https://surf.suckless.org/patches/notifications/)
  - [surf-popup-2.0.diff](https://surf.suckless.org/patches/popup-on-gesture/)
  - [surf-scrollmultiply-2.0.diff](https://surf.suckless.org/patches/scroll-faster/)
  - [surf-2.0-homepage.diff](https://surf.suckless.org/patches/homepage/)
- **[svkbd](https://tools.suckless.org/x/svkbd/)** - Simple Virtual Keyboard.
- **[sxiv](https://github.com/xyb3rt/sxiv)** - Simple X Image Viewer.
- **[tabbed](https://tools.suckless.org/tabbed/)** - generic tabbed interface.
- **[xclickroot](https://github.com/phillbush/xclickroot)** - run command on button press on root window.
- **[xclientprop](https://github.com/WieWaldi/suckless.X11/tree/master/xclientprop)** - show condenst X client properties through xmessage.
- **[xdotool](https://github.com/jordansissel/xdotool)** - command-line X11 automation tool.
- **[xmenu](https://github.com/phillbush/xmenu)** - menu utility for X.
- **[xmerge](https://github.com/WieWaldi/suckless.X11/tree/master/xmerge)** - Merge and apply .Xresource.
- **[xssstate](https://tools.suckless.org/x/xssstate/)** - display the state of the X screensaver extension.

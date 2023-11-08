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
- **compton** - a compositor for X11
- **dmenu** - dynamic menu (Version 5.0) contains the following patches.
  - dmenu-borderoption-20200217-bf60a1e.diff
  - dmenu-center-20200111-8cd37e1.diff
  - dmenu-mousesupport-5.0.diff
  - dmenu-mousesupporthoverbgcol-5.0.diff
  - dmenu-numbers-4.9.diff
  - dmenu-xresources-4.9.diff
- **dunst** - A customizable and lightweight notification-daemon
- **dwm** - dynamic window manager (Version 6.3, 2022-08-26) contains the following patches.
  - dwm-autostart-20210120-cb3f58a.diff
  - dwm-center-6.2.diff
  - dwm-cfacts-vanitygaps-6.2_combo.diff
  - dwm-fakefullscreen-20210714-138b405.diff
  - dwm-focusedontop-6.4.diff
  - dwm-focusonclick-20200110-61bb8b2.diff
  - dwm-colorbar-6.3.diff
  - dwm-layoutmenu-6.2.diff
  - dwm-layoutscroll-6.2.diff
  - dwm-monoclesymbol-6.2.diff
  - dwm-movestack-20211115-a786211.diff
  - dwm-namedscratchpads-6.2.diff
  - dwm-pertag-20200914-61bb8b2.diff
  - dwm-resizecorners-6.2.diff
  - dwm-status2d-6.3.diff
  - dwm-status2d-xrdb-6.2.diff
  - dwm-windowfollow-20221002-69d5652.diff
  - dwm-xresources-20210827-138b405.diff
- **farbfeld** - A lossless image format which is easy to parse, pipe and compress.
- **feh** — image viewer and cataloguer
- **lsw** - list windows
- **maim** - make image
- **rotwall** - rotate wallpapers
- **sent** - Simple plaintext presentation tool.
  - sent-invertedcolors-72d33d4.diff
  - sent-toggle-scm-20210119-2be4210.diff
  - sent-options-20190213-72d33d4.diff
- **slock** — simple X screen locker (Version 1.4) contains the following patches.
  - slock-capscolor-20170106-2d2a21a.diff
  - slock-colormessage-20200210-35633d4.diff
  - slock-xresources-20191126-53e56c7.diff
- **slop** - select operation
- **sselp** - Simple X selection printer
- **st** - simple terminal (Version 0.8.4) contains the following patches.
  - st-alpha-0.8.2.diff
  - st-blinking_cursor-20200531-a2a7044.diff
  - st-bold-is-not-bright-20190127-3be4cf1.diff
  - st-boxdraw_v2-0.8.3.diff
  - st-focus-20230610-68d1ad9.diff
  - st-iso14755-0.8.3.diff
  - st-iso14755-20180911-67d0cb6.diff
  - st-scrollback-20200419-72e3f6c.diff
  - st-scrollback-mouse-20191024-a2c479c.diff
  - st-xresources-20200604-9ba7ecf.diff
- **surf** - simple webkit-based browser (Version 2.0) contains the following patches.
  - surf-bookmarks-20170722-723ff26.diff
  - surf-dlconsole-20190919-d068a38.diff
  - surf-git-20170323-webkit2-searchengines.diff
  - surf-notifications-20201223-7dcce9e1.diff
  - surf-popup-2.0.diff
  - surf-scrollmultiply-2.0.diff
  - surf-2.0-homepage.diff
- **sxiv** - Simple X Image Viewer
- **tabbed** - generic tabbed interface
- **xclickroot** - run command on button press on root window
- **xclientprop** - show condenst X client properties through xmessage
- **xdotool** - command-line X11 automation tool
- **xmenu** - menu utility for X
- **xmerge** - Merge and apply .Xresource
- **xssstate** - display the state of the X screensaver extension

## Colors
No, it's not a "The Blue Oyster" theme. But I like these pink and purple colors anyway.
| Color         | Hex | RGB | CTERM |
|---|---|---|---|
| Deep Pink     |    ![#5f005f](https://via.placeholder.com/15/5f005f/5f005f.png) `#5f005f`| 95, 0, 95     | 53  |
| Dark Magenta  |    ![#8700af](https://via.placeholder.com/15/8700af/8700af.png) `#8700af`| 135, 0, 175   | 91  |
| Medium Purple |    ![#af87d7](https://via.placeholder.com/15/af87d7/af87d7.png) `#af87d7`| 175, 135, 215 | 140 |
| base03        |    ![#002b36](https://via.placeholder.com/15/002b36/002b36.png) `#002b36`|               |     |
| base02        |    ![#073642](https://via.placeholder.com/15/073642/073642.png) `#073642`|               |     |
| base01        |    ![#586e75](https://via.placeholder.com/15/586e75/586e75.png) `#586e75`|               |     |
| base00        |    ![#657b83](https://via.placeholder.com/15/657b83/657b83.png) `#657b83`|               |     |
| base0         |    ![#839496](https://via.placeholder.com/15/839496/839496.png) `#839496`|               |     |
| base1         |    ![#93a1a1](https://via.placeholder.com/15/93a1a1/93a1a1.png) `#93a1a1`|               |     |
| base2         |    ![#eee8d5](https://via.placeholder.com/15/eee8d5/eee8d5.png) `#eee8d5`|               |     |
| base3         |    ![#fdf6e3](https://via.placeholder.com/15/fdf6e3/fdf6e3.png) `#fdf6e3`|               |     |
| yellow        |    ![#b58900](https://via.placeholder.com/15/b58900/b58900.png) `#b58900`|               |     |
| orange        |    ![#cb4b16](https://via.placeholder.com/15/cb4b16/cb4b16.png) `#cb4b16`|               |     |
| red           |    ![#dc322f](https://via.placeholder.com/15/dc322f/dc322f.png) `#dc322f`|               |     |
| magenta       |    ![#d33682](https://via.placeholder.com/15/d33682/d33682.png) `#d33682`|               |     |
| violet        |    ![#6c71c4](https://via.placeholder.com/15/6c71c4/6c71c4.png) `#6c71c4`|               |     |
| blue          |    ![#268bd2](https://via.placeholder.com/15/268bd2/268bd2.png) `#268bd2`|               |     |
| cyan          |    ![#2aa198](https://via.placeholder.com/15/2aa198/2aa198.png) `#2aa198`|               |     |
| green         |    ![#859900](https://via.placeholder.com/15/859900/859900.png) `#859900`|               |     |

## Links/URLs/Credits  
[256 Colors Cheat Sheet](https://www.ditig.com/256-colors-cheat-sheet) - List of 256 colors for Xterm prompt (console)  
[Solarized Theme](https://github.com/altercation/solarized) - Precision colors for machines and people  

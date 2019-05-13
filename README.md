# suckless.X11
WieWaldi's fork of suckless.org dynamic window manager and other suckless implementations.
Yes, the name of this repository may be kinda missleading since it doesn't contain
suckless implementations only but other stuff as well.
This repo targets specially and only a minimal CentOS 7 installation.

## Requirements
A [detailed setup instruction](http://www.rz-amper.de/wiki/index.php/CentOS_7.x_from_Scratch)
will help you out but basically the following should work.
```
yum install -y vim git wget ftp make automake gcc gcc-c++ kernel-devel patch \
xorg-x11-xinit xorg-x11-apps xorg-x11-xbitmaps \
xorg-x11-drv-evdev xorg-x11-fonts-misc.noarch libXrandr-devel libX11-devel libXft-devel \
libXinerama-devel xterm imsettings ncurses-term ncurses-devel
```
## Installation
Edit each config.mk to match your local setup. Otherwise everything will get
installed into ~/bin. You may use setup.sh to get everything compiled and
installed in one go or simply compile one by one.

Afterwards you have to set uid for slock correctly
```
su - root
chown root:root slock
chmod u+s slock
```



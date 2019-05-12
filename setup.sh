#!/bin/sh
#
# +-------------------------------------------------------------------------+
# | Setup for suckless.X11 tools                                            |
# +-------------------------------------------------------------------------+
# | Copyright © 1996-2019 Waldemar Schroeer                                 |
# |                       lassmichinruhe@rz-amper.de                        |
# +-------------------------------------------------------------------------+

make=/bin/make        
cdir=$(pwd)

while :
do
    printf "\n\n Install Desktop and Suckless Tolls? >> "
    read antwoord
    case $antwoord in
        [yY] | [yY][Ee][Ss] )
            printf "\n Creating temp directory in your home directory.\n"
            mkdir -p ~/tmp
            printf "\n Preparing CentOS 7.\n"
            sudo yum install -y xorg-x11-xinit xorg-x11-apps xorg-x11-xbitmaps xorg-x11-utils xorg-x11-drv-evdev xorg-x11-fonts-misc.noarch libXrandr-devel libX11-devel libXft-devel libXinerama-devel xterm imsettings ncurses-term ncurses-devel webkitgtk4-devel glib2-devel gcr-devel mesa-libegl mesa-libgl mesa-dri-drivers
            printf "\n Installing Desktop and Suckless Tools to your home directory.\n"
            declare -a Xres=( ".Xresources" ".xinitrc" ".slocktext" ".fonts" )
            for i in "${Xres[@]}"
            do
                /bin/cp -r ${cdir}/${i} ~
            done
            /bin/fc-cache
            /bin/fc-list
            sleep 2
            declare -a sucklesstools=( "dwm" "dmenu" "st" "slock" "surf" "tabbed" )
            for i in "${sucklesstools[@]}"
            do
                cd ${cdir}/${i}
                $make install clean
            done
            break
            ;;
        [nN] | [n|N][O|o] )
            printf "\n Oh Boy, you should reconsider your decision."
            break
            ;;
        *)
            printf "\n Wut?\n\n"
    esac
done

while :
do
    printf "\n\n Make Clean? >> "
    read antwoord
    case 
        [yY] | [yY][Ee][Ss] )
            printf "\n Cleaning up.\n"
            declare -a sucklesstools=( "dwm" "dmenu" "st" "slock" "surf" "tabbed" )
            for i in "${sucklesstools[@]}"
            do
                cd ${cdir}/${i}
                $make clean
            done
            break
            ;;
        [nN] | [n|N][O|o] )
            printf "\n Oh Boy, you should reconsider your decision."
            break
            ;;
        *)
            printf "\n Wut?\n\n"
    esac

done

printf "\n\n I'm done\n\n"
exit 0

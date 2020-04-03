#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | Setup for suckless.X11 tools                                            |
# +-------------------------------------------------------------------------+
# | Copyright © 1996-2019 Waldemar Schroeer                                 |
# |                       lassmichinruhe@rz-amper.de                        |
# +-------------------------------------------------------------------------+

declare -a Xres=( ".Xresources" ".xinitrc" ".slocktext" )
declare -a sucklesstools=( "dwm" "dmenu" "st" "slock" "surf" "tabbed" "lsw")
make=/bin/make        
cdir=$(pwd)

function Display_Warning() {
    /bin/clear
    /bin/cat ${cdir}/setup-warning.txt
}

function Install_X11files() {
    /bin/mkdir -p ~/tmp
    for i in "${Xres[@]}"
    do
        /bin/cp -r ${cdir}/${i} ~
    done
    /bin/cp -r ${cdir}/.local/share/fonts ~/.local/share
    /bin/fc-cache
}

function Suckless_Install() {
    for i in "${sucklesstools[@]}"
    do
        cd ${cdir}/${i}
        $make install clean
    done
}

function Suckless_Clean() {
    printf "\n Cleaning up.\n"
    for i in "${sucklesstools[@]}"
    do
        cd ${cdir}/${i}
        $make clean
    done
}

while true; do
    Display_Warning
    printf "\n\n Go ahead? (Yes|No) >> "
    read antwoord
    case $antwoord in
        [yY] | [yY][Ee][Ss] )
            Install_X11files
            Suckless_Install
            Suckless_Clean
            printf "\n I'm done\n\n"
            break
            ;;
        [nN] | [n|N][O|o] )
            printf "\n Oh Boy, you should reconsider your decision."
            break
            ;;
        *)
            printf "  Wut?"
    esac
done

exit 0

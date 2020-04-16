#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | Setup for suckless.X11 tools                                            |
# +-------------------------------------------------------------------------+
# | Copyright © 1996-2019 Waldemar Schroeer                                 |
# |                       lassmichinruhe@rz-amper.de                        |
# +-------------------------------------------------------------------------+

backupdir="~/Backup.X11files.$$"
cdir=$(pwd)
make="/bin/make -j 4"

declare -a X11files=(
    ".Xresources"
    ".xinitrc"
    ".slocktext"
    )

declare -a sucklesstools=(
    "dwm"
    "dmenu"
    "st"
    "slock"
    "surf"
    "tabbed"
    "lsw"
    )

declare -a otherstuff=(
    "feh"
    "compton"
    )

function Display_Warning() {
    clear && cat ${cdir}/setup-warning.txt
}

function Install_X11files() {
    mkdir -p $backupdir
    mkdir -p ~/tmp
    for i in "${X11files[@]}"
    do
        if [ -f ~/$i ]; then
            printf "\n Moving $i to $backupdir"
            mv ~/$i $backupdir
        fi
        printf "\n Creating $i"
        /bin/cp -r ${cdir}/${i} ~
    done
    cp -r ${cdir}/.local/share/fonts ~/.local/share
    fc-cache
}

function Suckless_Install() {
    for i in "${sucklesstools[@]}"
    do
        cd ${cdir}/${i}
        $make install
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

function OtherStuff_Install() {
    for i in "${otherstuff[@]}"
    do
        cd ${cdir}/${i}
        $make
        $make install
    done
}

function OtherStuff_Clean() {
    printf "\n Cleaning up.\n"
    for i in "${otherstuff[@]}"
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
            OtherStuff_Install
            OtherStuff_Clean
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

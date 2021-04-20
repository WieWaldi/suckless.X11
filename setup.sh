#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | Setup for suckless.X11 tools                                            |
# +-------------------------------------------------------------------------+
# | Copyright © 1996-2019 Waldemar Schroeer                                 |
# |                       lassmichinruhe@rz-amper.de                        |
# +-------------------------------------------------------------------------+

backupdir="${HOME}/Backup.X11files.$$"
cdir=$(pwd)
make="/bin/make -j 4"
cmake="/bin/cmake"

declare -a X11files=(
    ".Xresources"
    ".xinitrc"
    ".xsession"
    ".slocktext"
    )

declare -a sucklesstools=(
    "dmenu"
    "dwm"
    "dwm-helper"
    "lsw"
    "slock"
    "sselp"
    "st"
    "stw"
    "surf"
    "tabbed"
    "xssstate"
    )

declare -a naelstrof=(
    "slop"
    "maim"
    )

declare -a otherstuff=(
    "feh"
    "compton"
    "sxiv"
    "xdotool"
    "rotwall"
    "xclickroot"
    "xmenu"
    "xmerge"
    )

Display_Warning() {
    clear && cat ${cdir}/setup-warning.txt
}

Create_Dir() {
    [ ! -d "${backupdir}" ] && mkdir -p ${backupdir}
    [ ! -d "${HOME}/tmp" ] && mkdir -p ${HOME}/tmp
    [ ! -d "${HOME}/.config" ] && mkdir -p ${HOME}/.config
    [ ! -d "${HOME}/.config/dunst" ] && mkdir -p ${HOME}/.config/dunst
    [ ! -d "${HOME}/.local/lib" ] && mkdir -p ${HOME}/.local/lib
    [ ! -d "${HOME}/.local/lib64" ] && mkdir -p ${HOME}/.local/lib64
    [ ! -d "${HOME}/Downloads" ] && mkdir -p ${HOME}/Downloads
    [ ! -d "${HOME}/Screenshots" ] && mkdir -p ${HOME}/Screenshots
}

Install_X11files() {
    for i in "${X11files[@]}"
    do
        if [ -f ${HOME}/${i} ]; then
            printf "\n Moving ${i} to ${backupdir}"
            mv ${HOME}/${i} ${backupdir}
        fi
        printf "\n Creating ${i}"
        /bin/cp -r ${cdir}/X.org.files/${i} ${HOME}
    done
    cp -r ${cdir}/.local/share/fonts ${HOME}/.local/share
    cp -r ${cdir}/.local/share/wallpapers ${HOME}/.local/share
    cp -r ${cdir}/.local/share/icons ${HOME}/.local/share
    cp -r ${cdir}/compton/compton.conf ${HOME}/.config
    cp -r ${cdir}/dunst/dunstrc ${HOME}/.config/dunst
    cp -r ${cdir}/X.org.files/.xsession
    chmod 755 ${HOME}/.local/bin/.xsession
    fc-cache
}

Suckless_Install() {
    for i in "${sucklesstools[@]}"
    do
        cd ${cdir}/${i}
        ${make} install
    done
}

Suckless_Clean() {
    printf "\n Cleaning up.\n"
    for i in "${sucklesstools[@]}"
    do
        cd ${cdir}/${i}
        ${make} clean
    done
}

OtherStuff_Install() {
    for i in "${otherstuff[@]}"
    do
        cd ${cdir}/${i}
        ${make}
        ${make} install
    done
}

OtherStuff_Clean() {
    printf "\n Cleaning up.\n"
    for i in "${otherstuff[@]}"
    do
        cd ${cdir}/${i}
        ${make} clean
    done
}

naelstrof_Install() {
    for i in "${naelstrof[@]}"
    do
        cd ${cdir}/${i}
        ${cmake} -DCMAKE_INSTALL_PREFIX="~/.local" ./
        ${make} install
    done
}

naelstrof_Clean() {
    printf "\n Cleaning up.\n"
    for i in "${naelstrof[@]}"
    do
        cd ${cdir}/${i}
        git clean -fdX
    done
}

while true; do
    Display_Warning
    printf "\n\n Go ahead? (Yes|No) >> "
    read antwoord
    case ${antwoord} in
        [yY] | [yY][Ee][Ss] )
            Create_Dir
            Install_X11files
            Suckless_Install
            Suckless_Clean
            OtherStuff_Install
            OtherStuff_Clean
            naelstrof_Install
            naelstrof_Clean
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

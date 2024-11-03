#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | setup.sh                                                                   |
# +----------------------------------------------------------------------------+
# |       Usage: Executed without any options                                  |
# | Description: Setup script to compile and install suckless.X11              |
# |    Requires: bash_framework.sh                                             |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 4.2                                                           |
# |     Created: 05.12.2023                                                    |
# |    Revision: ---                                                           |
# |                                                                            |
# | Copyright © 2023 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Include bash-framework.sh --------------------------------------------+
# set -o errexit
# set -o pipefail
export BASH_FRMWRK_MINVER=4
export LANG="en_US.UTF-8"
export base_dir="$(dirname "$(readlink -f "$0")")"
export cdir=$(pwd)
export scriptname="${BASH_SOURCE##*/}"
export scriptdir="${BASH_SOURCE%/*}"
export datetime="$(date "+%Y-%m-%d-%H-%M-%S")"
export logfile="${scriptdir}/${datetime}.log"
export framework_width=80

if [[ -f "${scriptdir}"/bash-framework.sh ]]; then
    BASH_FRMWRK_FILE="${scriptdir}/bash-framework.sh"
else
    test_file=$(which bash-framework.sh 2>/dev/null)
    if [[ $? = 0 ]]; then
        BASH_FRMWRK_FILE="${test_file}"
        unset test_file
    else
        echo -e "\nNo Bash Framework found.\n"
        exit 1
    fi
fi

source "${BASH_FRMWRK_FILE}"
if [[ "${BASH_FRMWRK_VER}" -lt "${BASH_FRMWRK_MINVER}" ]]; then
    echo -e "\nI've found version ${BASH_FRMWRK_VER} of bash_framework.sh, but I'm in need of version ${BASH_FRMWRK_MINVER}."
    echo -e "You may get the newest version from https://github.com/WieWaldi/bash-framework.sh\n"
    exit 1
fi

# +----- Variables ------------------------------------------------------------+

notice="notice-setup.txt"
backupdir="${HOME}/Backup.X11files.$$"
cdir="$(dirname "$(readlink -f "${0}")")"
make="/bin/make -j 4"
cmake="/bin/cmake"

declare -a config_Directories=(
    "tmp"
    ".config"
    ".config/dunst"
    ".config/password_store"
    ".local/bin"
    ".local/lib"
    ".local/lib64"
    ".local/share/man/man1"
    "Downloads"
    "Notes"
    "Pictures"
    "Pictures/Collect"
    "Pictures/Screenshots"
    "Music/Youtube/MP3"
    "Music/Youtube/Source"
    )

declare -a X11files=(
    ".Xresources"
    ".xinitrc"
    ".xsession"
    ".slocktext"
    )

declare -a applist=(
    "dmenu"
    "dwm"
    "dwm-helper"
    "farbfeld"
    "lsw"
    "sent"
    "slock"
    "sselp"
    "st"
    "stw"
    "surf"
    "tabbed"
    "xssstate"
    "feh"
    "sxiv"
    "xdotool"
    "rotwall"
    "xclickroot"
    "xmenu"
    "xmerge"
    )

# +----- Functions ------------------------------------------------------------+

create_Backup_Directory() {
    __echo_left "Creating Backup Directory:"
    mkdir -p ${backupdir}
    __echo_Result
}
create_Config_Directories() {
    __echo_Left "Config Directories:"
    if [[ "${get_Config_Directories}" = "yes" ]]; then
        for i in "${config_Directories[@]}"; do
            __echo_Left "Preparing Directory: ${i}"
            if [[ $(__check_File_Name ${HOME}/${i}) = 1 ]]; then
                __echo_Right "Already in Place"
            elif [[ $(__check_File_Name ${HOME}/${i}) = 3 ]]; then
                mkdir -p ${HOME}/${i} >> ${logfile} 2>&1
                __echo_Result
            else
                __echo_Failed
            fi
        done
    else
        __echo_Skipped
    fi
}

install_X11files() {
    for i in "${X11files[@]}"
    do
        if [ -f ${HOME}/${i} ]; then
            __echo_Left "Moving ${i} to ${backupdir}"
            mv ${HOME}/${i} ${backupdir}
            __echo_Result
        fi
        __echo_Left "Creating ${i}"
        /bin/cp -r ${cdir}/X.org.files/${i} ${HOME}
        __echo_Result
    done
    cp -r ${cdir}/.local/share/fonts ${HOME}/.local/share
    cp -r ${cdir}/.local/share/wallpapers ${HOME}/.local/share
    cp -r ${cdir}/.local/share/icons ${HOME}/.local/share
    cp -r ${cdir}/.config/picom.conf ${HOME}/.config
    cp -r ${cdir}/.config/dunst/dunstrc ${HOME}/.config/dunst
    cp -r ${cdir}/X.org.files/.xsession ${HOME}
    chmod 755 ${HOME}/.xsession
    fc-cache
}

install_suckless() {
    for i in "${applist[@]}"
    do
        __echo_Left "Compiling and installing ${i}"
        cd ${cdir}/${i}
        ${make} install >> ${logfile} 2>&1
        __echo_Result
    done
}

clean_suckless() {
    for i in "${applist[@]}"
    do
        __echo_Left "Cleaning up after intalling ${i}"
        cd ${cdir}/${i}
        ${make} clean >> ${logfile} 2>&1
        __echo_Result
    done
}

# +----- Main -----------------------------------------------------------------+

__display_Text_File blue ${scriptdir}/${notice}

if [[ "$(__read_Antwoord_YN "Do you want to proceed?")" = "no" ]]; then
    __echo_Title "Exit"
    exit 0
fi
get_Config_Directories="yes"
create_Config_Directories
create Backup_Directory
install_X11files
install_suckless
clean_suckless


# +----- End ------------------------------------------------------------------+
echo -e "\n\n"
exit 0


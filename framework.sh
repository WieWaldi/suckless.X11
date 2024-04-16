#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | framework.sh                                                               |
# +----------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

echo "2"

# +----- Variables ------------------------------------------------------------+
RED=$(tput setaf 1)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
YN="(Yes|${BRIGHT}No${NORMAL}) >> "

# +----- Functions ------------------------------------------------------------+
echo_equals() {
    counter=0
    while [  $counter -lt "$1" ]; do
    printf '='
    (( counter=counter+1 ))
    done
}

echo_title() {
    title=$1
    ncols=$(tput cols)
    nequals=$(((width-${#title})/2-1))
    tput setaf 4 0 0
    echo_equals "$nequals"
    tput setaf 6 0 0
    printf " %s " "$title"
    tput setaf 4 0 0
    echo_equals "$nequals"
    tput sgr0
    echo
}

echo_Right() {
    text=${1}
    echo
    tput cuu1
    tput cuf "$((${width} - 1))"
    tput cub ${#text}
    echo "${text}"
}

echo_OK() {
    tput setaf 2 0 0
    echo_Right "[ OK ]"
    tput sgr0
}

echo_Done() {
    tput setaf 2 0 0
    echo_Right "[ Done ]"
    tput sgr0
}

echo_NotNeeded() {
    tput setaf 3 0 0
    echo_Right "[ Not Needed ]"
    tput sgr0
}

echo_Skipped() {
    tput setaf 3 0 0
    echo_Right "[ Skipped ]"
    tput sgr0
}

echo_Failed() {
    tput setaf 1 0 0
    echo_Right "[ Failed ]"
    tput sgr0
}

echo_Error_Msg() {
    echo -n -e "\n${RED} [ Error ]${NORMAL} ${1}\n\n"
}

antwoord() {
    read -p "${1}" antwoord
        if [[ ${antwoord} == [yY] || ${antwoord} == [yY][Ee][Ss] ]]; then
            echo "yes"
        else
            echo "no"
        fi
}

display_Notice() {
    echo "3"
    clear
    tput setaf 6
    cat ${cdir}/$1
    tput sgr0
    proceed="$(antwoord "Do you want to proceed? ${YN}")"
}

clear_Logfile() {
    if [[ -f ${logfile} ]]; then
        rm ${logfile}
    fi
}

get_User() {
    if ! [[ $(id -u) = 0 ]]; then
        echo_Error_Msg "This script must be run as root."
        exit 1
    fi
}

get_OperatingSystem() {
    os=$(uname -s)
    kernel=$(uname -r)
    architecture=$(uname -m)
}

get_Distribution() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        distribution=$NAME
        version=$VERSION_ID
        case ${ID} in
            rhel|centos)
                packagelistext="${ID}.${VERSION_ID::1}"
                ;;
            fedora)
                packagelistext="${ID}.${VERSION_ID}"
                ;;
        esac
        echo -e "\nSeems to be:"
        echo -e "  ${distribution} ${version} ${kernel} ${architecture}\n" 
    else
        echo_Error_Msg "I need /etc/os-release to figure what distribution this is."
        exit 1    
    fi
}

LogfileLocation() {
    echo -n -e "\nLogfile: ${logfile}\r"
    echo_OK
}

# +----- Main -----------------------------------------------------------------+
exit 0

#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | Name of the Script                                                      |
# +-------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+

cdir=$(pwd)
logfile=prepare.log

display_Warning () {
    /bin/clear
    /bin/cat ${cdir}/prepare-warning.txt
    while true; do
        printf "\n\nDo you want to proceed? (Yes|No)"
        read antwoord
        case ${antwoord} in
            [yY] | [yY][Ee][Ss] )
                proceed=yes
                break
            ;;
            [nN] | [nN][Oo] )
                proceed=no
                break
            ;;
            *)
                printf " Wut?"
            ;;
        esac
    done
}

get_User () {
    if ! [[ $(id -u) = 0 ]]; then
        printf "\n This script must be run as root.\n\n" 
        exit 1
    fi
}

clear_Logfile () {
    if [[ -f ${logfile} ]]; then
        rm ${logfile}
    fi
}

get_OperatingSystem () {
    os=$(uname -s)
    kernel=$(uname -r)
    architecture=$(uname -m)
}

get_Distribution () {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        distribution=$NAME
        version=$VERSION_ID
    else
        echo -e "\nError: I need /etc/os-release to figure what distribution this is."
        exit 1    
    fi
}


get_User
display_Warning
if [[ "${proceed}" = "no" ]]; then
    exit 1
fi

get_OperatingSystem
if [[ "${os}" = "Linux" ]]; then
    get_Distribution
    echo -e "\nSeems to be:"
    echo -e "  ${os} ${distribution} ${version} ${kernel} ${architecture}" 
    case ${distribution} in
        "Fedora" )
            printf "Fedora"
        ;;
        "CentOS Linux" )
            printf "CentOS"
        ;;
        "Arch Linux" )
            printf "Arch Linux"
        ;;
        * )
            printf "Somethings wrong"
        ;;
    esac
elif [[ "${os}" = "AIX" ]]; then
    echo -e "Error: I'm so sorry, but AIX is currently not supported"
    exit 1

elif [[ "${os}" = "SunOS" ]]; then
    echo -e "Error: I'm so sorry, but SunOS/Solaris is currently not supported"
    exit 1

elif [[ "${os}" = "Darwin" ]]; then
    echo -e "Error: I'm so sorry, but Darwin is currently not supported"
    exit 1

elif [[ "${os}" = "FreeBSD" ]]; then
    echo -e "Warning: Support for FreeBSD is currently ridimentary."
    exit 1
fi


printf "\n I'm done.\n\n"
exit 0




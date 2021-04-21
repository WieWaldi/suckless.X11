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
}

get_User () {
    if ! [[ $(/bin/id -u) = 0 ]]; then
        printf "\n This script must be run as root.\n\n" 
        exit 1
    fi
}

get_Distribution () {
    os=$(uname -s)
    kernel=$(uname -r)
    architecture=$(uname -m)

    if [[ "${os}" = "Linux" ]]; then
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            distribution=$NAME
            echo -e "\nSeems to be ${distribution}"
        else
            echo -e "\nError: I need /etc/os-release to figure what distribution this is."
            exit 1    
        fi
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
}


getUser
display_Warning
get_Distribution

echo "Bla ${distribution}"

exit 0




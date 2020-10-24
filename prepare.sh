#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | prepare.sh                                                              |
# +-------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+

cdir=$(pwd)

function Disable_SELINUX () {
    sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
}
function Display_Warning () {
    /bin/clear
    /bin/cat ${cdir}/prepare-warning.txt
}

function Copy_Files {
    cp ${cdir}/etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d
}

function Install_CentOS_7 {
    yum install -y vim git wget ftp make cmake automake gcc gcc-c++ kernel-devel kernel-headers patch net-tools bind-utils epel-release asciidoc perl
    yum install -y xorg-x11-xinit xorg-x11-apps xorg-x11-xbitmaps xorg-x11-utils xterm xclip
    yum install -y xorg-x11-drv-evdev xorg-x11-drv-synaptics xorg-x11-fonts-misc.noarch libXrandr-devel libX11-devel libXft-devel libXScrnSaver-devel libcurl-devel libXt-devel libXtst-devel
    yum install -y libXinerama-devel imsettings ncurses-term ncurses-devel imlib2-devel libexif-devel giflib-devel glm-devel glew-devel libjpeg-turbo-devel
    yum install -y gcr-devel mesa-libEGL mesa-libGL mesa-dri-drivers dbus-x11 dbus-devel
    yum install -y webkitgtk4-devel glib2-devel gcr-devel mesa-dri-drivers xorg-x11-utils libconfig-devel pango-devel gtk2-devel
    yum install -y "gstreamer*"
    yum install -y ntp ntpdate
}

function Install_CentOS_8() {
    dnf config-manager --enable PowerTools
    dnf install -y vim git wget ftp make cmake automake gcc gcc-c++ kernel-devel kernel-headers patch net-tools bind-utils epel-release asciidoc perl
    dnf install -y xorg-x11-xinit xorg-x11-apps xorg-x11-xbitmaps xorg-x11-utils xterm xclip
    dnf install -y xorg-x11-drv-evdev xorg-x11-drv-synaptics xorg-x11-fonts-misc.noarch libXrandr-devel libX11-devel libXft-devel libXScrnSaver-devel libcurl-devel libXt-devel libXtst-devel
    dnf install -y libXinerama-devel imsettings ncurses-term ncurses-devel imlib2-devel libexif-devel giflib-devel glm-devel glew-devel libjpeg-turbo-devel
    dnf install -y gcr-devel mesa-libEGL mesa-libGL mesa-dri-drivers dbus-x11 dbus-devel
    dnf install -y webkitgtk4-devel glib2-devel gcr-devel mesa-dri-drivers xorg-x11-utils libconfig-devel pango-devel gtk2-devel
    dnf install -y "gstreamer*"
    dnf install -y chrony
}

function Install_GoogleChrome() {
    cp ${cdir}/etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d
    yum install -y google-chrome-stable
}

function Install_VirtualBox() {
    cp ${cdir}/etc/yum.repos.d/virtualbox.repo /etc/yum.repos.d
    yum install -y VirtualBox-6.0
}

if ! [[ $(/bin/id -u) = 0 ]]; then
    printf "\n This script must be run as root.\n\n" 
    exit 1
else
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        os=$NAME
        version=$VERSION_ID
        if [[ "${os}" = "CentOS Linux" ]]; then
            Display_Warning
            while true; do
                printf "\n Do you want to get Google Chrome installed as well? (Yes|No) >> "
                read antwoord
                case ${antwoord} in
                    [yY] | [yY][Ee][Ss] )
                        InstallGoogleChrome=yes
                        break
                    ;;
                    [nN] | [n|N][O|o] )
                        InstallGoogleChrome=no
                        break
                    ;;
                    *)
                        printf "  Wut?"
                    ;;
                esac
            done

            while true; do
                printf "\n Do you want to get VirtualBox installed as well? (Yes|No) >> "
                read antwoord
                case ${antwoord} in
                    [yY] | [yY][Ee][Ss] )
                        InstallVirtualBox=yes
                        break
                    ;;
                    [nN] | [n|N][O|o] )
                        InstallVirtualBox=no
                        break
                    ;;
                    *)
                        printf "  Wut?"
                    ;;
                esac
            done

            if [[ "${version}" = "7" ]]; then
                printf "\n This is CentOS Linux Version 7.\n"
                DisableSELINUX
                Copy_Files
                Install_CentOS_7
            elif [[ "${version}" == "8" ]]; then
                printf "\n This is CentOS Linux Version 8.\n"
                DisableSELINUX
                Copy_Files
                Install_CentOS_8
            fi

            if [[ "${InstallGoogleChrome}" == "yes" ]]; then
                printf "\n Installing Google Chrome as well.\n"
                Install_GoogleChrome
            fi

            if [[ "${InstallVirtualBox}" == "yes" ]]; then
                printf "\n Installing VirtualBox as well.\n"
                Install_VirtualBox
            fi

        else
            printf " This is not CentOS.\n\n"
            exit 1
        fi
    else
            printf "\n Could not find /etc/os-release."
            printf "\n Is this even Linux?!\n\n"
            exit 1
    fi
fi

printf "\n I'm done.\n\n"
exit 0

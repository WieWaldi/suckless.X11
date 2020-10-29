#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | prepare.sh                                                              |
# +-------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+

cdir=$(pwd)
logfile=prepare.log

disable_SELINUX () {
    sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
}
display_Warning () {
    /bin/clear
    /bin/cat ${cdir}/prepare-warning.txt
}

copy_Files {
    cp ${cdir}/etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d
    cp ${cdir}/etc/sddm.conf /etc
    cp ${cdir}/X.org.files/dwm.desktop /usr/share/xsessions
    cp ${cdir}/X.org.files/xinit-compat.desktop /usr/share/xsessions
}

install_CentOS_7 () {
    yum install -y vim git wget ftp make cmake automake gcc gcc-c++ kernel-devel kernel-headers patch net-tools bind-utils epel-release asciidoc perl htop >> prepare.log
    yum install -y xorg-x11-xinit xorg-x11-apps xorg-x11-xbitmaps xorg-x11-utils xterm xclip sddm >> prepare.log
    yum install -y xorg-x11-drv-evdev xorg-x11-drv-synaptics xorg-x11-fonts-misc.noarch libXrandr-devel libX11-devel libXft-devel libXScrnSaver-devel libcurl-devel libXt-devel libXtst-devel >> prepare.log
    yum install -y libXinerama-devel imsettings ncurses-term ncurses-devel imlib2-devel libexif-devel giflib-devel glm-devel glew-devel libjpeg-turbo-devel >> prepare.log
    yum install -y gcr-devel mesa-libEGL mesa-libGL mesa-dri-drivers dbus-x11 dbus-devel >> prepare.log
    yum install -y webkitgtk4-devel glib2-devel gcr-devel mesa-dri-drivers xorg-x11-utils libconfig-devel pango-devel gtk2-devel >> prepare.log
    yum install -y libdrm-devel libpciaccess-devel libxcb-devel jq fftw-devel iniparser libglvnd-devel elfutils-libelf-devel >> prepare.log
    yum install -y alsa-utils alsa-lib-devel alsa-plugins-pulseaudio pulseaudio pulseaudio-libs-devel pulseaudio-libs-glib2 pulseaudio-module-x11 pulseaudio-utils >> prepare.log
    yum install -y "gstreamer*" >> prepare.log
    yum install -y ntp ntpdate >> prepare.log
}

install_CentOS_8 () {
    echo -e "\nInstalling Repository: CentOS-8 - PowerTools"
    dnf config-manager --enable PowerTools >> ${logfile}
    echo -e "\nInstalling Repository: Extra Packages for Enterprise Linux 8"
    dnf install -y epel-release >> ${logfile}
    echo -e "\nInstalling Repository: RPM Fusion for EL 8 - Free - Updates"
    dnf install y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm >> ${logfile}
    echo -e "\nInstalling Repository: RPM Fusion for EL 8 - Nonfree - Updates"
    dnf install y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm >> ${logfile}

    IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.CentOS8))'
    echo -e "\nInstalling the following packages:"
    echo ${packages[@]}
    dnf install -y ${packages[@]} >> ${logfile}
}

install_GoogleChrome() {
    echo -e "\nInstalling Repository: google-chrome"
    cp ${cdir}/etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d
    yum install -y google-chrome-stable >> ${logfile}
}

install_VirtualBox() {
    echo -e "\nInstalling Repository: VirtualBox"
    cp ${cdir}/etc/yum.repos.d/virtualbox.repo /etc/yum.repos.d
    yum install -y VirtualBox-6.0 >> ${logfile}
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
            display_Warning
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
                disable_SELINUX
                copy_Files
                install_CentOS_7
            elif [[ "${version}" == "8" ]]; then
                printf "\n This is CentOS Linux Version 8.\n"
                disable_SELINUX
                copy_Files
                install_CentOS_8
            fi

            if [[ "${InstallGoogleChrome}" == "yes" ]]; then
                printf "\n Installing Google Chrome as well.\n"
                install_GoogleChrome
            fi

            if [[ "${InstallVirtualBox}" == "yes" ]]; then
                printf "\n Installing VirtualBox as well.\n"
                install_VirtualBox
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

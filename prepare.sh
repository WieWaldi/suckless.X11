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

copy_Files () {
    cp ${cdir}/etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d
    cp ${cdir}/etc/sddm.conf /etc
    cp ${cdir}/X.org.files/dwm.desktop /usr/share/xsessions
    cp ${cdir}/X.org.files/xinit-compat.desktop /usr/share/xsessions
}

install_CentOS_7 () {
    echo -e "\nInstalling Repository: Extra Packages for Enterprise Linux 7"
    yum install -y epel-release >> ${logfile} 2>&1
    echo -e "\nInstalling Repository: RPM Fusion for EL 8 - Free - Updates"
    yum localinstall -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm >> ${logfile} 2>&1
    echo -e "\nInstalling Repository: RPM Fusion for EL 8 - Nonfree - Updates"
    yum localinstall -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm >> ${logfile} 2>&1
    IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.CentOS8))'
    echo -e "\nInstalling the following packages:"
    echo ${packages[@]}
    dnf install -y ${packages[@]} >> ${logfile} 2>&1
}

install_CentOS_8 () {
    echo -e "\nInstalling Repository: CentOS-8 - PowerTools"
    dnf config-manager --enable PowerTools >> ${logfile} 2>&1
    echo -e "\nInstalling Repository: Extra Packages for Enterprise Linux 8"
    dnf install -y epel-release >> ${logfile} 2>&1
    echo -e "\nInstalling Repository: RPM Fusion for EL 8 - Free - Updates"
    dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm >> ${logfile} 2>&1
    echo -e "\nInstalling Repository: RPM Fusion for EL 8 - Nonfree - Updates"
    dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm >> ${logfile} 2>&1
    IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.CentOS8))'
    echo -e "\nInstalling the following packages:"
    echo ${packages[@]}
    dnf install -y ${packages[@]} >> ${logfile} 2>&1
}

install_GoogleChrome() {
    echo -e "\nInstalling Repository: google-chrome"
    cp ${cdir}/etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d
    yum install -y google-chrome-stable >> ${logfile} 2>&1
}

install_VirtualBox() {
    echo -e "\nInstalling Repository: VirtualBox"
    cp ${cdir}/etc/yum.repos.d/virtualbox.repo /etc/yum.repos.d
    yum install -y VirtualBox-6.0 >> ${logfile} 2>&1
}

if ! [[ $(/bin/id -u) = 0 ]]; then
    printf "\n This script must be run as root.\n\n" 
    exit 1
else
    if [[ -f ${logfile} ]]; then
        rm ${logfile}
    fi
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

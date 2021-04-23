#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | prepare.sh                                                              |
# +-------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+

# +----- Variables ---------------------------------------------------------+
cdir=$(pwd)
logfile=prepare.log

# +----- Functions ---------------------------------------------------------+
display_Warning () {
    /bin/clear
    /bin/cat ${cdir}/prepare-warning.txt
    while true; do
        printf "\n\nDo you want to proceed? (Yes|No) >> "
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
                echo " Wut?"
            ;;
        esac
    done
}

get_User () {
    if ! [[ $(id -u) = 0 ]]; then
        echo "\nError: This script must be run as root.\n\n" 
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
    echo -e "\nSeems to be:"
    echo -e "  ${os} ${distribution} ${version} ${kernel} ${architecture}\n" 
}

get_GoogleChrome () {
    while true; do
        printf "\nDo you want to get Google Chrome installed as well? (Yes|No) >> "
        read antwoord
        case ${antwoord} in
            [yY] | [yY][Ee][Ss] )
                InstallGoogleChrome=yes
                break
            ;;
            [nN] | [nN][Oo] )
                InstallGoogleChrome=no
                break
            ;;
            *)
                echo "  Wut?"
            ;;
        esac
    done
}

get_VirtualBox () {
    while true; do
        printf "\nDo you want to get VirtualBox installed as well? (Yes|No) >> "
        read antwoord
        case ${antwoord} in
            [yY] | [yY][Ee][Ss] )
                InstallVirtualBox=yes
                break
            ;;
            [nN] | [nN][Oo] )
                InstallVirtualBox=no
                break
            ;;
            *)
                echo "  Wut?"
            ;;
        esac
    done
}

install_GoogleChrome() {
    echo -e "\nInstalling Repository: google-chrome"
    cp ${cdir}/etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d
    dnf install -y google-chrome-stable >> ${logfile} 2>&1
}

install_VirtualBox() {
    echo -e "\nInstalling Repository: VirtualBox"
    cp ${cdir}/etc/yum.repos.d/virtualbox.repo /etc/yum.repos.d
    dnf install -y VirtualBox-6.0 >> ${logfile} 2>&1
}

disable_SELINUX () {
    echo "Disabling SELinux."
    sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
}

copy_Files () {
    echo "Copying files."
    cp ${cdir}/etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d
    cp ${cdir}/etc/sddm.conf /etc
    cp ${cdir}/X.org.files/dwm.desktop /usr/share/xsessions
    cp ${cdir}/X.org.files/xinit-compat.desktop /usr/share/xsessions
}

install_Fedora3x () {
    echo "Fedora"
    echo "Installing Repository: RPM Fusion for Fedora - Free - Updates"
    dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm >> ${logfile} 2>&1
    echo "Installing Repository: RPM Fusion for Fedora - Nonfree - Updates"
    dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> ${logfile} 2>&1
    IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.Fedora3x))'
    echo "Installing the following packages:"
    echo ${packages[@]}
    dnf install -y ${packages[@]} >> ${logfile} 2>&1
    systemctl enable sddm
    systemctl set-default graphical.target
}
 
install_CentOS_7 () {
    echo "Installing Repository: Extra Packages for Enterprise Linux 7"
    yum install -y epel-release >> ${logfile} 2>&1
    echo "Installing Repository: RPM Fusion for EL 8 - Free - Updates"
    yum localinstall -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm >> ${logfile} 2>&1
    echo -e "Installing Repository: RPM Fusion for EL 8 - Nonfree - Updates"
    yum localinstall -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm >> ${logfile} 2>&1
    IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.CentOS7))'
    echo "Installing the following packages:"
    echo ${packages[@]}
    yum install -y ${packages[@]} >> ${logfile} 2>&1
    systemctl enable sddm
    systemctl set-default graphical.target
}

install_CentOS_8 () {
    echo "Installing Repository: CentOS-8 - PowerTools"
    dnf config-manager --enable PowerTools >> ${logfile} 2>&1
    echo "Installing Repository: Extra Packages for Enterprise Linux 8"
    dnf install -y epel-release >> ${logfile} 2>&1
    echo "Installing Repository: RPM Fusion for EL 8 - Free - Updates"
    dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm >> ${logfile} 2>&1
    echo "Installing Repository: RPM Fusion for EL 8 - Nonfree - Updates"
    dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm >> ${logfile} 2>&1
    IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.CentOS8))'
    echo "Installing the following packages:"
    echo ${packages[@]}
    dnf install -y ${packages[@]} >> ${logfile} 2>&1
    systemctl enable sddm
    systemctl set-default graphical.target
}

# +----- Main --------------------------------------------------------------+
get_User
display_Warning
if [[ "${proceed}" = "no" ]]; then
    exit 1
fi

get_OperatingSystem
get_Distribution
if [[ "${os}" = "Linux" ]]; then
    case ${distribution} in
        "Fedora" )
            if [[ "${version}" != 3* ]]; then
                echo -e "Error: This is not a supported version of Fedora"
                exit 1
            fi
            get_GoogleChrome
            get_VirtualBox
            disable_SELINUX
            copy_Files
            install_Fedora3x
            if [[ "${InstallGoogleChrome}" = "yes" ]]; then
                echo "Installing Google Chrome as well."
                install_GoogleChrome
            fi

            if [[ "${InstallVirtualBox}" = "yes" ]]; then
                echo "Installing VirtualBox as well."
                install_VirtualBox
            fi
        ;;
        "CentOS Linux" )
            if [[ "${version}" -ne "7" && "${version}" -ne "8" ]]; then
                echo -e "Error: This is not a supported version of CentOS"
                exit 1
            fi
            get_GoogleChrome
            get_VirtualBox
            disable_SELINUX
            copy_Files
            if [[ "${version}" = "7" ]]; then
                install_CentOS_7
            elif [[ "${version}" = "8" ]]; then
                install_CentOS_8
            fi
            if [[ "${InstallGoogleChrome}" = "yes" ]]; then
                echo "Installing Google Chrome as well.\n"
                install_GoogleChrome
            fi

            if [[ "${InstallVirtualBox}" = "yes" ]]; then
                echo "Installing VirtualBox as well.\n"
                install_VirtualBox
            fi
        ;;
        "Arch Linux" )
            echo "Arch Linux"
        ;;
        * )
            echo "This seems to be an unsupported Linux distribution."
            exit 1
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
    get_Distribution
fi


echo -e "I'm done.\n\n"
exit 0




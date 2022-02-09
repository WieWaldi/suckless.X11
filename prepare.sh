#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | prepare.sh                                                                 |
# +----------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Variables ------------------------------------------------------------+
datetime="$(date "+%Y-%m-%d-%H-%M-%S")"
cdir=$(pwd)
logfile="/tmp/suckless.X11_prepare_${datetime}.log"
width=80
cdir=$(pwd)

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
    clear
    tput setaf 6
    cat ${cdir}/notice.txt
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
    else
        echo_Error_Msg "I need /etc/os-release to figure what distribution this is."
        exit 1    
    fi
    echo -e "\nSeems to be:"
    echo -e "  ${os} ${distribution} ${version} ${kernel} ${architecture}\n" 
}

LogfileLocation() {
    echo -n -e "\nLogfile: ${logfile}\r"
    echo_OK
}

HostName_query() {
    SetHostname="$(antwoord "Do you want to set hostname? ${YN}")"
    if [[ "${SetHostname}" = "yes" ]]; then
        read -p "Hostname: " gethostname
    fi
}

HostName_set() {
    echo -n -e "Setting Hostname to: ${gethostname}\r"
    if [[ "${SetHostname}" = "yes" ]]; then
        hostnamectl set-hostname ${gethostname}
        echo_Done
    else
        echo_Skipped
    fi
}

GoogleChrome_query() {
    InstallGoogleChrome="$(antwoord "Do you want to get Google Chrome installed? ${YN}")"
}

GoogleChrome_install() {
    echo -n -e "Installing Repository: google-chrome\r"
    if [[ "${InstallGoogleChrome}" = "yes" ]]; then
        cp ${cdir}/etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d
        dnf install -y google-chrome-stable >> ${logfile} 2>&1
        echo_Done
    else
        echo_Skipped
    fi
}

VirtualBox_query() {
    InstallVirtualBox="$(antwoord "Do you want to get VirtualBox installed? ${YN}")"
}

VirtualBox_install() {
    echo -n -e "Installing Repository: VirtualBox\r"
    if [[ "${InstallVirtualBox}" = "yes" ]]; then
        cp ${cdir}/etc/yum.repos.d/virtualbox.repo /etc/yum.repos.d
        dnf install -y VirtualBox-6.0 >> ${logfile} 2>&1
        echo_Done
    else
        echo_Skipped
    fi
}

SshRootLogin_query() {
    DisableSshRoot="$(antwoord "Disable SSH login for root user? "${YN})"
}

SshRootLogin_disable() {
    echo -n -e "Disabling SSH login for root user.\r"
    if [[ "${DisableSshRoot}" = "yes" ]]; then
        grep "^PermitRootLogin" /etc/ssh/sshd_config > /dev/null 2>&1
        retVal=$?
        if [[ "${retVal}" -ne 0 ]]; then
            echo -e "\nPermitRootLogin no" >> /etc/ssh/sshd_config
            echo_Done
        else
            sed -i "s/^PermitRootLogin\ yes/PermitRootLogin\ no/" /etc/ssh/sshd_config >>${logfile} 2>&1
            retVal=$?
            if [[ "${retVal}" -ne 0 ]]; then
                echo_Failed
            else
                echo_Done
            fi
        fi
    else
        echo_Skipped
    fi
}

SELinux_query() {
    DisableSELinux="$(antwoord "Disable SELinux? ${YN}")"
}

SELinux_disable() {
    echo -n -e "Disabling SELinux.\r"
    if [[ "${DisableSELinux}" = "yes" ]]; then
        sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
        echo_Done
    else
        echo_Skipped
    fi
}

SDDM_query() {
    EnableSDDM="$(antwoord "Enable Simple Desktop Display Manager? ${YN}")"
}

SDDM_enable() {
    if [[ "${EnableSDDM}" = "yes" ]]; then
        statusdm="$(systemctl is-active display-manager.service)"
        if [[ "${statusdm}" = "active" ]]; then
            echo "Disabling current Display Manager."
            systemctl disable display-manager.service
        fi
        echo "Enabling SDDM."
        systemctl enable sddm.service
        systemctl set-default graphical.target
    fi
}

SUDO_Timeout_query() {
    SetSudoTimeout="$(antwoord "Set SUDO Password Timeout? ${YN}")"
    if [[ "${SetSudoTimeout}" = "yes" ]]; then
        read -p "SUDO Password Timeout: " getsudotimeout
    fi
}

SUDO_Timeout_set() {
    echo -n -e "Setting SUDO Timeout to: ${getsudotimeout}\r"
    if [[ "${SetSudoTimeout}" = "yes" ]]; then
        grep "^Defaults timestamp_timeout=" /etc/sudoers > /dev/null 2>&1
        retVal=$?
        if [[ "${retVal}" -ne 0 ]]; then
            echo -e "\nDefaults timestamp_timeout=${getsudotimeout}" >> /etc/sudoers
        else
            sed -i "s/^Defaults\ timestamp_timeout=.*$/Defaults\ timestamp_timeout=${getsudotimeout}/" /etc/sudoers
            retVal=$?
            if [[ "${retVal}" -ne 0 ]]; then
                echo_Failed
            else
                echo_Done
            fi
        fi
    else
        echo_Skipped
    fi
}

FilesXorg_query() {
    FilesXorg="$(antwoord "Copy Xorg related files? ${YN}")"
}

FilesXorg_copy() {
    if [[ "${FilesXorg}" = "yes" ]]; then
        printf "Copying Xorg related files."
        cp ${cdir}/etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d
        cp ${cdir}/etc/sddm.conf /etc
        cp ${cdir}/X.org.files/dwm.desktop /usr/share/xsessions
        cp ${cdir}/X.org.files/xinit-compat.desktop /usr/share/xsessions
    fi
}

RHEL8_CodereadyBuilder_query() {
    EnableCodeReady="$(antwoord "Enable CodeReady Linux Builder? ${YN}")"
}

RHEL8_CodereadyBuilder_enable() {
    printf "Enabling CodeReady Linux Builder."
    if [[ "${EnableCodeReady}" = "yes" ]]; then
        subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms >> ${logfile} 2>&1
        echo_Done
    else
        echo_Skipped
    fi
}

RHEL8_DefaultPackages_query() {
    InstallDefaultPackages="$(antwoord "Install default packages? ${YN}")"
}

RHEL8_DefaultPackages_install() {
    echo -n -e "Installing Default Packages.\r"
    if [[ "${InstallDefaultPackages}" = "yes" ]]; then
        IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.RHEL8))'
        dnf install -y ${packages[@]} >> ${logfile} 2>&1
        echo_Done
    else
        echo_Skipped
    fi
}

Fedora3x_prepare() {
    echo "Installing Repository: RPM Fusion for Fedora - Free - Updates"
    dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm >> ${logfile} 2>&1
    echo "Installing Repository: RPM Fusion for Fedora - Nonfree - Updates"
    dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> ${logfile} 2>&1
    IFS=$'\r\n' GLOBIGNORE='*' command eval  'packages=($(cat ./packages.Fedora3x))'
    echo "Installing the following packages:"
    echo ${packages[@]}
    dnf install -y ${packages[@]} >> ${logfile} 2>&1
    echo "Setting hostname to: ${gethostname}"
    hostnamectl set-hostname ${gethostname}
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
    systemctl enable sddm
    systemctl set-default graphical
}


# +----- Main -----------------------------------------------------------------+
get_User
display_Notice
if [[ "${proceed}" = "no" ]]; then
    exit 1
fi

echo_title "Choose Options"

get_OperatingSystem
get_Distribution

if [[ "${os}" = "Linux" ]]; then
    case ${distribution} in
        "Red Hat Enterprise Linux" )
            GoogleChrome_query
            VirtualBox_query
            HostName_query
            SELinux_query
            SUDO_Timeout_query
            SshRootLogin_query
            RHEL8_CodereadyBuilder_query
            RHEL8_DefaultPackages_query
            
            echo_title "Prepare"
            
            GoogleChrome_install
            VirtualBox_install
            HostName_set
            SELinux_disable
            SshRootLogin_disable
            SUDO_Timeout_set
            RHEL8_CodereadyBuilder_enable
            RHEL8_DefaultPackages_install
            LogfileLocation
            ;;
        "Fedora" )
            if [[ "${version}" != 3* ]]; then
                echo_Error_Msg "This is not a supported version of Fedora."
                exit 1
            fi
            GoogleChrome_query
            VirtualBox_query
            HostName_query
            SELinux_query
            SUDO_Timeout_query
            SshRootLogin_query
            RHEL8_CodereadyBuilder_query
            RHEL8_DefaultPackages_query
            
            echo_title "Prepare"
            ;;
        "CentOS Linux" )
            if [[ "${version}" -ne "7" && "${version}" -ne "8" ]]; then
                echo_Error_Msg "This is not a supported version of CentOS."
                exit 1
            fi
            get_GoogleChrome
            get_VirtualBox
            disable_SELINUX
            copy_Files
            enable_SDDM
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
            echo_Error_Msg "Arch Linux is currently not supported."
            exit 1
            ;;
        * )
            echo_Error_Msg "This seems to be an unsupported Linux distribution."
            exit 1
            ;;
    esac
elif [[ "${os}" = "SunOS" ]]; then
    echo_Error_Msg "SunOS/Solaris is currently not supported."
    exit 1

elif [[ "${os}" = "FreeBSD" ]]; then
    echo_Error_Msg "FreeBSD is currently not supported."
    exit 1
fi

echo_title "I'm done."
echo -e "\n\n"
exit 0

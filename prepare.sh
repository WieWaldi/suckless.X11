#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | suckless.X11/prepare.sh                                                    |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Script to prepare OS for suckless.X11/setup.sh                |
# |    Requires: bash_framework.sh                                             |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 3                                                             |
# |     Created: 24.08.2023                                                    |
# |    Revision: ---                                                           |
# |                                                                            |
# | Copyright © 2023 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+






# +----- Help and Usage (Must start at line 25 and must stop with "######" ----+
#
# example.sh [options]
#
# This script is part of the suckless.X11 repository and is used to prepare
# the OS to use the setup script afterwards. It gives you options to install
# software and packages. In addition you may set host name and enable or
# disable other features.
#
# Options...
#  -h, --help           Print out help
#
#####

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

# +----- Option Handling ------------------------------------------------------+
while [[ $# -gt 0 ]]; do
    case "$1" in
        -\?|-h|-help|--help) __exit_Help ;;                    # Standard help option
        -doc|--doc)          __exit_Help ;;
        --) shift; break ;;                                 # Force end of user option
        -*) __exit_Usage 10 "Unknown option \"${1}\"" ;;    # Unknown command line option
        *)  break ;;                                        # Unforced end of user options
    esac
    shift                                                   # Shift to next option
done

# +----- Variables ------------------------------------------------------------+
notice="src/notice-prepare.txt"

# +----- Functions ------------------------------------------------------------+

GoogleChrome_query() {
    InstallGoogleChrome="$(__read_Antwoord_YN "Do you want to get Google Chrome installed?")"
}

GoogleChrome_install() {
    __echo_Left "Installing Repository: google-chrome"
    if [[ "${InstallGoogleChrome}" = "yes" ]]; then
        __echo_Left "Adding google-chrome.repo"
        cp ${cdir}/src/etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d >>${logfile} 2>&1
        __echo_Result
        __echo_Left "Installing google-chrome-stable"
        dnf install -y google-chrome-stable >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

HostName_query() {
    SetHostname="$(__read_Antwoord_YN "Do you want to set hostname?")"
    if [[ "${SetHostname}" = "yes" ]]; then
        gethostname="$(__read_Line "Hostname")"
    fi
}

HostName_set() {
    __echo_Left "Setting Hostname to: ${gethostname}"
    if [[ "${SetHostname}" = "yes" ]]; then
        hostnamectl set-hostname ${gethostname} >>${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

VirtualBox_query() {
    InstallVirtualBox="$(__read_Antwoord_YN "Do you want to get VirtualBox installed?")"
}

VirtualBox_install() {
    __echo_Left "Installing Repository: VirtualBox"
    if [[ "${InstallVirtualBox}" = "yes" ]]; then
        __echo_Left "Adding virtualbox.repo"
        cp ${cdir}/etc/yum.repos.d/virtualbox.repo /etc/yum.repos.d >> ${logfile} 2>&1
        __echo_Result
        dnf install -y VirtualBox-6.0 >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

SshRootLogin_query() {
    DisableSshRoot="$(__read_Antwoord_YN "Disable SSH login for root user? ")"
}

SshRootLogin_disable() {
    __echo_Left "Disabling SSH login for root user"
    if [[ "${DisableSshRoot}" = "yes" ]]; then
        grep "^PermitRootLogin" /etc/ssh/sshd_config > /dev/null 2>&1
        retVal=$?
        if [[ "${retVal}" -ne 0 ]]; then
            echo -e "\nPermitRootLogin no" >> /etc/ssh/sshd_config
            echo_Result
        else
            sed -i "s/^PermitRootLogin\ yes/PermitRootLogin\ no/" /etc/ssh/sshd_config >>${logfile} 2>&1
            __echo_Result
        fi
    else
        __echo_Skipped
    fi
}

SELinux_query() {
    DisableSELinux="$(__read_Antwoord_YN "Disable SELinux?")"
}

SELinux_disable() {
    __echo_Left "Disabling SELinux."
    if [[ "${DisableSELinux}" = "yes" ]]; then
        sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

SDDM_query() {
    EnableSDDM="$(__read_Antwoord_YN "Enable Simple Desktop Display Manager?")"
}

SDDM_enable() {
    if [[ "${EnableSDDM}" = "yes" ]]; then
        statusdm="$(systemctl is-active display-manager.service)"
        if [[ "${statusdm}" = "active" ]]; then
            __echo_Left "Disabling current Display Manager"
            systemctl disable display-manager.service >> ${logfile} 2>&1
            __echo_Result
        fi
        __echo_Left "Enabling SDDM."
        systemctl enable sddm.service >> ${logfile} 2>&1
        __echo_Result
        __echo_Left "Setting Graphical Target"
        systemctl set-default graphical.target >> ${logfile} 2>&1
        __echo_Result
    fi
}

SUDO_Timeout_query() {
    SetSudoTimeout="$(__read_Antwoord_YN "Set SUDO Password Timeout?")"
    if [[ "${SetSudoTimeout}" = "yes" ]]; then
        getsudotimeout="$(__read_Line "SUDO Passwort Timeout")"
    fi
}

SUDO_Timeout_set() {
    __echo_Left "Setting SUDO Timeout to: ${getsudotimeout}"
    if [[ "${SetSudoTimeout}" = "yes" ]]; then
        grep "^Defaults timestamp_timeout=" /etc/sudoers >> ${logfile} 2>&1
        retVal=$?
        if [[ "${retVal}" -ne 0 ]]; then
            echo -e "\nDefaults timestamp_timeout=${getsudotimeout}" >> /etc/sudoers
        else
            sed -i "s/^Defaults\ timestamp_timeout=.*$/Defaults\ timestamp_timeout=${getsudotimeout}/" /etc/sudoers >> ${logfile} 2>&1
            __echo_Result
        fi
    else
        __echo_Skipped
    fi
}

FilesXorg_query() {
    FilesXorg="$(__read_Antwoord_YN "Copy Xorg related files?")"
}

FilesXorg_copy() {
    if [[ "${FilesXorg}" = "yes" ]]; then
        __echo_Left "Copying files to /etc/X11/xorg.conf.d/"
        cp ${cdir}/src/etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d >> ${logfile} 2>&1
        __echo_Result
        __echo_Left "Copying /etc/sddm.conf"
        cp ${cdir}/src/etc/sddm.conf /etc >> ${logfile} 2>&1
        __echo_Result
        __echo_Left "Copying /usr/share/xsessions/dwm.desktop"
        cp ${cdir}/src/X.org.files/dwm.desktop /usr/share/xsessions >> ${logfile} 2>&1
        __echo_Result
        __echo_Left "Copying /usr/share/xsessions/xinit-compat.dektop"
        cp ${cdir}/src/X.org.files/xinit-compat.desktop /usr/share/xsessions >> ${logfile} 2>&1
        __echo_Result
    fi
}

PowerTools_query() {
    EnablePowerTools="$(__read_Antwoord_YN "Enable PowerTools?")"
}

PowerTools_enable() {
    __echo_Left "Enabling Power Tools"
    if [[ "${EnablePowerTools}" = "yes" ]]; then
        dnf config-manager --enable powertools >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

EPEL_query() {
    EnableEPEL="$(__read_Antwoord_YN "Enable EPEL Repository?")"
}

EPEL_enable() {
    __echo_Left "Enabling EPEL Repository"
    if [[ "${EnableEPEL}" = "yes" ]]; then
        dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

RPMFusion_query() {
    EnableRPMFusionFree="$(__read_Antwoord_YN "Enable RPM Fusion Free Repository?")"
    EnableRPMFusionNonFree="$(__read_Antwoord_YN "Enable RPM Fusion NonFree Repository?")"
}

RPMFusion_enable() {
    __echo_Left "Enabling RPM Fusion Free Repository."
    if [[ "${EnableRPMFusionFree}" = "yes" ]]; then
        case ${distribution} in
            "Red Hat Enterprise Linux" )
                dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm >> ${logfile} 2>&1
                __echo_Result
            ;;
            "Fedora Linux" )
                dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm >> ${logfile} 2>&1
                __echo_Result
            ;;
            "CentOS Linux" )
                dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm >> ${logfile} 2>&1
                __echo_Result
            ;;
        esac
        __echo_Left "Enable fedora-cisco-openh264."
        dnf config-manager setopt fedora-cisco-openh264.enabled=1
        __echo_Result
        __echo_Left "dnf makecache."
        dnf makecache >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
    __echo_Left "Enabling RPM Fusion Non-Free Repository."
    if [[ "${EnableRPMFusionNonFree}" = "yes" ]]; then
        case ${distribution} in
            "Red Hat Enterprise Linux" )
                dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm >> ${logfile} 2>&1
                __echo_Result
            ;;
            "Fedora Linux" )
                dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> ${logfile} 2>&1
                __echo_Result
            ;;
            "CentOS Linux" )
                dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm >> ${logfile} 2>&1
                __echo_Result
            ;;
        esac
        __echo_Left "dnf makecache."
        dnf makecache >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

RHEL8_CodereadyBuilder_query() {
    EnableCodeReady="$(__read_Antwoord_YN "Enable CodeReady Linux Builder?")"
}

RHEL8_CodereadyBuilder_enable() {
    __echo_Left "Enabling CodeReady Linux Builder"
    if [[ "${EnableCodeReady}" = "yes" ]]; then
        subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

DefaultPackages_query() {
    InstallDefaultPackages="$(__read_Antwoord_YN "Install default packages?")"
}

DefaultPackages_install() {
    __echo_Left "Installing Default Packages"
    if [[ "${InstallDefaultPackages}" = "yes" ]]; then
        IFS=$'\r\n' GLOBIGNORE='*' command eval 'packages=($(cat ./src/packages/packages.${packagelistext}))'
        echo -e "\n\nPackage List: ${packagelistext}\n" >> ${logfile} 2>&1
        echo -e "List of packages: ${packages[@]}" >> ${logfile} 2>&1
        dnf install -y ${packages[@]} >> ${logfile} 2>&1
        __echo_Result
    else
        __echo_Skipped
    fi
}

# +----- Main -----------------------------------------------------------------+

__display_Text_File blue ${scriptdir}/${notice}

if [[ "$(__read_Antwoord_YN "Do you want to proceed?")" = "no" ]]; then
    __echo_Title "Exit"
    exit 0
fi

if ! [[ $(id -u) = 0 ]]; then
    __exit_Error 10 "This script must be run as root."
fi

__get_OperatingSystem
__get_Distribution

if [[ "${os}" = "Linux" ]]; then
    case ${distribution} in
        "Red Hat Enterprise Linux" )
            GoogleChrome_query
            VirtualBox_query
            HostName_query
            SELinux_query
            SUDO_Timeout_query
            SshRootLogin_query
            EPEL_query
            RPMFusionFree_query
            RHEL8_CodereadyBuilder_query
            RHEL8_DefaultPackages_query
            
            echo_title "Prepare"
            
            GoogleChrome_install
            VirtualBox_install
            HostName_set
            SELinux_disable
            SUDO_Timeout_set
            SshRootLogin_disable
            EPEL_enable
            RHEL8_CodereadyBuilder_enable
            RHEL8_DefaultPackages_install
            LogfileLocation
            ;;
        "Fedora"|"Fedora Linux" )
            GoogleChrome_query
            VirtualBox_query
            HostName_query
            SELinux_query
            SUDO_Timeout_query
            SshRootLogin_query
            RPMFusion_query
            DefaultPackages_query
            FilesXorg_query
            SDDM_query
            
            echo_title "Prepare"
            
            GoogleChrome_install
            VirtualBox_install
            HostName_set
            SELinux_disable
            SUDO_Timeout_set
            SshRootLogin_disable
            RPMFusion_enable
            DefaultPackages_install
            FilesXorg_copy
            SDDM_enable
            echo "End" >> ${logfile}
            ;;
        "CentOS Linux" )
            GoogleChrome_query
            VirtualBox_query
            HostName_query
            SELinux_query
            SUDO_Timeout_query
            SshRootLogin_query
            EPEL_query
            RPMFusionFree_query
            
            RHEL8_DefaultPackages_query
            
            echo_title "Prepare"
            
            GoogleChrome_install
            VirtualBox_install
            HostName_set
            SELinux_disable
            SUDO_Timeout_set
            SshRootLogin_disable
            EPEL_enable
            RHEL8_CodereadyBuilder_enable
            RHEL8_DefaultPackages_install
            LogfileLocation
            ;;
        * )
            __exit_Error 10 "This seems to be an unsupported Linux distribution."
            ;;
    esac
elif [[ "${os}" = "SunOS" ]]; then
    __exit_Error 10 "SunOS/Solaris is currently not supported."

elif [[ "${os}" = "FreeBSD" ]]; then
    __exit_Error "FreeBSD is currently not supported."
else
    __exit_Error 10 "Something's wrong, so I'm exiting here."
fi


__echo_Title "I'm done."
echo -e "\n\n"
exit 0

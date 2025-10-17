#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# tj5os setup scripting (image mode) 

#SeLinux custom kernel configs
setsebool -P domain_kernel_load_modules on


# Install the CachyOS Kernel
dnf remove -y kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt
dnf -y copr enable bieszczaders/kernel-cachyos-lto
dnf install -y kernel-cachyos-lto
dnf -y copr disable bieszczaders/kernel-cachyos-lto

# Install CachyOS Kernel Addons
dnf -y copr enable bieszczaders/kernel-cachyos-addons
dnf install -y cachyos-ksm-settings scx-manager scx-scheds
dnf -y copr disable bieszczaders/kernel-cachyos-addons

#remove firefox
dnf5 -y remove firefox

# Install dra for BUILD PROCESS ONLY
mkdir -p /tmp/tj5os-build/
cd /tmp/tj5os-build
# Grab Latest Release from devmatteini/dra
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/devmatteini/dra/refs/heads/main/install.sh | bash -s -- --to .
cd dra
./dra download --select "brave-browser-{tag}-1.x86_64.rpm" brave/brave-browser
dnf5 -y install ./*.rpm 


# Install bazaar and other apps from ublue 
dnf5 -y copr enable ublue-os/packages
dnf5 -y install bazaar 
dnf5 -y copr disable ublue-os/packages

dnf5 -y copr enable xxmitsu/mesa-git
dnf5 -y update
dnf5 -y copr disable xxmitsu/mesa-git

dnf5 -y install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Steam 
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf5 -y config-manager setopt fedora-cisco-openh264.enabled=1
dnf5 -y install steam gamescope

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#Dotfiles installation and configurations (will only be used if no .config files for the respecitve apps are in the users home directory)
#mkdir /usr/share/backgrounds/tj5os-cosmic/43
#wget -O {wallpaper-name).{fileextenstion} https://raw.githubusercontent.com/pollux78/linuxnext-wallpapers/refs/heads/main/Games/20241128_010441.jpg


# Cleanup
cd / 
rm -rf /tmp/tj5os-build


#### Example for enabling a System Unit File

systemctl enable podman.socket

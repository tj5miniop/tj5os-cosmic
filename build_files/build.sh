#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# tj5os setup scripting (image mode) 

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

# Install bazaar and other apps from ublue 
dn5 -y copr enable ublue-os/packages
dnf5 -y install bazaar 
dn5 -y copr disable ublue-os/packages

dnf5 -y copr enable xxmitsu/mesa-git
dnf5 -y update
dnf5 -y copr diable xxmitsu/mesa-git

dnf5 -y install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo



# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

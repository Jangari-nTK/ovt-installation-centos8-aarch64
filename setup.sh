#!/bin/bash

sed -i -e "s/enabled=0/enabled=1/g" /etc/yum.repos.d/CentOS-PowerTools.repo

dnf group install -y "Development Tools"

dnf install -y glib2-devel.aarch64 libmspack-devel.aarch64 pam-devel.aarch64 openssl-devel.aarch64 \
    xmlsec1-devel.aarch64 libxml2-devel.aarch64 libtirpc-devel.aarch64 rpcgen.aarch64 libtool-ltdl-devel \
    git

dnf install -y libX11-devel.aarch64 libXext-devel.aarch64 libXinerama-devel.aarch64 libXi libXi-devel \
    libXrender-devel libXrandr-devel libXtst-devel gdk-pixbuf2-xlib-devel.aarch64 gtk3-devel.aarch64 \
    gtkmm30-devel.aarch64

dnf install -y git
git clone https://github.com/vmware/open-vm-tools.git
cd open-vm-tools/open-vm-tools

autoreconf -i
./configure
make
make install
ldconfig

ln -s /usr/local/bin/vmtoolsd /usr/bin/vmtoolsd
ln -s /usr/local/bin/VGAuthService /usr/bin/VGAuthService

cd ../../

cat ./usr/lib/systemd/system/vmtoolsd.service > /usr/lib/systemd/system/vmtoolsd.service
cat ./usr/lib/systemd/system/vgauthd.service > /usr/lib/systemd/system/vgauthd.service
cat ./usr/lib/udev/99-vmware-scsi-udev.rules > /usr/lib/udev/99-vmware-scsi-udev.rules

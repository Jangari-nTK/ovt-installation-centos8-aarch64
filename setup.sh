#!/bin/bash

sed -i -e "s/enabled = 1/enabled = 0/g" /etc/yum.repos.d/CentOS-PowerTools.repo

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

autoreconf
./configure

<< COMMENT
make
make install
ldconfig

cat > /etc/systemd/system/vmtoolsd.service << EOL
[Unit]
Description=Service for virtual machines hosted on VMware
Documentation=https://github.com/vmware/open-vm-tools
ConditionVirtualization=vmware
After=vgauth.service
Before=cloud-init-local.service
DefaultDependencies=no

[Service]
ExecStart=/usr/local/bin/vmtoolsd
TimeoutStopSec=5

[Install]
WantedBy=multi-user.target
Also=vgauthd.service
EOL
COMMENT

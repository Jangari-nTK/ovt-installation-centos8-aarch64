# open-vm-tools installation script for CentOS 8 aarch64

This script installs some dependencies. See the script for details.

Note: Not for production use, testing purpose only.

# Usage

1. Install CentOS 8 aarch64 (Server with GUI) guest on ESXi-Arm.
2. Install git.
```
$ sudo dnf install -y git
```
3. Clone this repository.
```
$ git clone https://github.com/Jangari-nTK/ovt-installation-centos8-aarch64.git
```
4. Run the script as root.
```
$ cd ovt-installation-centos8-aarch64
$ chmod +x setup.sh
$ sudo ./setup.sh
```
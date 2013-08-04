#!/bin/bash

set -ux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05

KERNEL_FILE=boot/vmlinuz-3.2.37-030237-virtual
KERNEL_DEB=linux-image-3.2.37-030237-virtual_3.2.37-030237.201301152335_amd64.deb

if ! [ -e "$KERNEL_FILE" ]; then
    wget -q http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.2.37-precise/$KERNEL_DEB
    ar vx $KERNEL_DEB
    tar -xjvf data.tar.bz2
fi

qemu-system-x86_64 \
  -kernel $KERNEL_FILE \
  -drive file="$WORKSPACE/$BUILDROOT_VER/output/images/rootfs.ext2" \
  -append root=/dev/sda

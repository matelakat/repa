#!/bin/bash

set -ux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05
LOCAL_KERNEL="$THIS_DIR/vmlinuz"

KERNEL_FILE=boot/vmlinuz-3.2.37-030237-virtual
KERNEL_DEB=linux-image-3.2.37-030237-virtual_3.2.37-030237.201301152335_amd64.deb

if ! [ -e "$LOCAL_KERNEL" ]; then
    TMPDIR=$(mktemp -d)
    (
        cd "$TMPDIR"
        wget -q http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.2.37-precise/$KERNEL_DEB
        ar vx $KERNEL_DEB
        tar -xjvf data.tar.bz2
        mv "$KERNEL_FILE" "$LOCAL_KERNEL"
    )
fi

qemu-system-x86_64 \
  -kernel "$LOCAL_KERNEL" \
  -net none \
  -drive file="$WORKSPACE/$BUILDROOT_VER/output/images/rootfs.ext2" \
  -append root=/dev/sda

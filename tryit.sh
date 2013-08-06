#!/bin/bash

set -ux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05
LOCAL_KERNEL="$THIS_DIR/vmlinuz"

KERNEL_DEB=linux-image-3.2.48-030248-virtual_3.2.48-030248.201306291335_amd64.deb
KERNEL_URL="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.2.48-precise/$KERNEL_DEB"
KERNEL_FILE=boot/vmlinuz-3.2.48-030248-virtual

if ! [ -e "$LOCAL_KERNEL" ]; then
    TMPDIR=$(mktemp -d)
    (
        cd "$TMPDIR"
        wget -q "$KERNEL_URL"
        ar vx $KERNEL_DEB
        tar -xjvf data.tar.bz2
        mv "$KERNEL_FILE" "$LOCAL_KERNEL"
    )
fi

qemu-system-x86_64 \
  -kernel "$LOCAL_KERNEL" \
  -net nic,model=virtio \
  -net user,hostfwd=::2223-:22,vlan=0 \
  -drive file="$WORKSPACE/$BUILDROOT_VER/output/images/rootfs.ext2" \
  -append root=/dev/sda



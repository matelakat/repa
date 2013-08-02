#!/bin/bash

set -ux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05

TMPDIR="$THIS_DIR/.cucc"

sudo mkdir -p $TMPDIR
sudo tar -xf "$WORKSPACE/$BUILDROOT_VER/output/images/rootfs.tar" -C "$TMPDIR"
sudo chroot "$TMPDIR" /bin/sh

echo "$TMPDIR"

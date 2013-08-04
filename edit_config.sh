#!/bin/bash

set -eux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05
CROSSTOOL_DIR="$THIS_DIR/.crosstool"
XTOOLS_DIR="$CROSSTOOL_DIR/x-tools"

# Copy over the packages
find packages/ -maxdepth 1 -mindepth 1 -type d | while read pkgpath; do
    cp -r "$pkgpath" "$WORKSPACE/$BUILDROOT_VER/package/"
done


(
    cd "$WORKSPACE/$BUILDROOT_VER"
    make defconfig BR2_DEFCONFIG="$THIS_DIR/repa_defconfig"
    sed -ie "s,/data/matelakat/crosstoolng/x-tools,$XTOOLS_DIR,g" .config
    make menuconfig
    sed -ie "s,$XTOOLS_DIR,/data/matelakat/crosstoolng/x-tools,g" .config
    make savedefconfig BR2_DEFCONFIG="$THIS_DIR/repa_defconfig"
)

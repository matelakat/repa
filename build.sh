#!/bin/bash

set -eux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05
CROSSTOOL_DIR="$THIS_DIR/.crosstool"
XTOOLS_DIR="$CROSSTOOL_DIR/x-tools"
OVERLAY_DIR="$THIS_DIR/overlay"

# Copy over the packages
find packages/ -maxdepth 1 -mindepth 1 -type d | while read pkgpath; do
    cp -r "$pkgpath" "$WORKSPACE/$BUILDROOT_VER/package/"
done

# Patch config file
patch -p 0 --forward < package_config.patch || true

(
    cd "$WORKSPACE/$BUILDROOT_VER"
    make defconfig BR2_DEFCONFIG="$THIS_DIR/repa_defconfig"
    sed -ie "s,/data/matelakat/crosstoolng/x-tools,$XTOOLS_DIR,g" .config
    sed -ie "s,overlay_directory_comes_here,$OVERLAY_DIR,g" .config
    make
)


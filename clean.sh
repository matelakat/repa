#!/bin/bash

set -eux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05
CROSSTOOL_DIR="$THIS_DIR/.crosstool"
XTOOLS_DIR="$CROSSTOOL_DIR/x-tools"

(
    cd "$WORKSPACE/$BUILDROOT_VER"
    make defconfig BR2_DEFCONFIG="$THIS_DIR/repa_defconfig"
    sed -ie "s,/data/matelakat/crosstoolng/x-tools,$XTOOLS_DIR,g" .config
    make clean
)

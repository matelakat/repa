#!/bin/bash

set -eux

THIS_DIR=$(cd "$(dirname $0)" && pwd)
WORKSPACE=.workspace
BUILDROOT_VER=buildroot-2013.05

(
    cd "$WORKSPACE/$BUILDROOT_VER"
    make source BR2_DEFCONFIG="$THIS_DIR/repa_defconfig"
)


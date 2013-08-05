#!/bin/bash

set -eux

THIS_DIR=$(cd "$(dirname $0)" && pwd)

CROSSTOOL_DIR="$THIS_DIR/.crosstool"

export PATH="${PATH}:$THIS_DIR/.crosstool-ng/bin"

(
    cd .toolchain-config
    ct-ng menuconfig
    sed -e "s,$CROSSTOOL_DIR/src,/data/matelakat/crosstoolng/src,g" \
        -e "s,$CROSSTOOL_DIR/x-tools,/data/matelakat/crosstoolng/x-tools,g" \
        .config > "$THIS_DIR/tchain.config"
)

#!/bin/bash

set -eux

THIS_DIR=$(cd "$(dirname $0)" && pwd)

CROSSTOOL_DIR="$THIS_DIR/.crosstool"

export PATH="${PATH}:$THIS_DIR/.crosstool-ng/bin"

mkdir -p .toolchain-config
(
    cd .toolchain-config
    ct-ng x86_64-unknown-linux-gnu
)

mkdir -p "$CROSSTOOL_DIR"
mkdir -p "$CROSSTOOL_DIR/src"
mkdir -p "$CROSSTOOL_DIR/x-tools"

sed -e "s,/data/matelakat/crosstoolng/src,$CROSSTOOL_DIR/src,g" \
    -e "s,/data/matelakat/crosstoolng/x-tools,$CROSSTOOL_DIR/x-tools,g" \
    "$THIS_DIR/tchain.config" > .toolchain-config/.config

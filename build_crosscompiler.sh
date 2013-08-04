#!/bin/bash

set -eux

THIS_DIR=$(cd "$(dirname $0)" && pwd)

CROSSTOOL_DIR="$THIS_DIR/.crosstool"

export PATH="${PATH}:$THIS_DIR/.crosstool-ng/bin"

mkdir -p .toolchain-config
(
    cd .toolchain-config
    ct-ng build.4
)

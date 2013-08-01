repa
====

My buildroot experiments

## Create workspace

Download buildroot

    ./create_workspace.sh

## Edit config

It edits the buildroot config, and saves the changes to `repa_defconfig`.

    ./edit_config.sh

## Download dependencies

Asks buildroot to download the dependencies.

    ./download_dependencies.sh

## Build the system

Ask buildroot to build the system.

    ./build.sh

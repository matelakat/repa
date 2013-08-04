repa
====

My buildroot crosstool-ng experiments. The goal is to be able to compile a
system that contains all neccessary components to run a python web application.

The packages in the target system:

 - uwsgi
 - python 2.7

The build process is:

 - create a cross compiler
 - create a root filesystem with the required packages

## Create cross compiler

Clone crosstool-ng sources, and check out a specific version, and install it:

    ./install_crosstool_ng.sh

Use the configuration file `tchain.config` provided, but replace the target
paths:

    ./configure_crosscompiler.sh

Build the cross compiler. This is a long operation. It will build the cross
compiler. Takes around an hour on my machine (Core 2 Duo P8700 with ssd).

    ./build_crosscompiler.sh

## Create the root filesystem

Download buildroot

    ./create_workspace.sh

## Download dependencies

Asks buildroot to download the dependencies.

    ./download_dependencies.sh

## Build the system

Ask buildroot to build the system.

    ./build.sh

## Try out the new system

This will download an ubuntu kernel, that matches our configuration, and fire
up a qemu, so you can try out the system:

    ./tryit.sh

## Development: Edit config

Should you wish to adjust the system, please do it so with the provided script
file.  It will make sure, that the configuration files are saved to version
controlled files within this repository, thus the process could be repeated.
The following script edits the buildroot config, and saves the changes to
`repa_defconfig`.

    ./edit_config.sh

## Clean out everything

Please refer to the buildroot manual on when to do a full clean.

    ./clean.sh

# Notes

Some random notes that are not captured to scripts.

## How to create the config patch

This is how you create a Buildroot origin patch

    diff -u  .workspace/buildroot-2013.05/package/Config.in.orig \
      .workspace/buildroot-2013.05/package/Config.in > package_config.patch

This is how you apply it

    patch -p 0 --forward < package_config.patch

## Crosstool-ng config file

    cp tchain/.config tchain.config

## Useful documents

 - http://osmz.mrl.cz/buildroot.html
 - http://www.bootc.net/archives/2012/05/26/how-to-build-a-cross-compiler-for-your-raspberry-pi/

## UWSGI modifications

    mkdir uwsgi
    cd uwsgi
    wget -qO - http://projects.unbit.it/downloads/uwsgi-1.9.14.tar.gz | tar -xzf -
    cp -r uwsgi-1.9.14 uwsgi-1.9.14.orig
    diff -ur uwsgi-1.9.14.orig uwsgi-1.9.14 > ../packages/uwsgi/uwsgi-1.9.14-010.patch

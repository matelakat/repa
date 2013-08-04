repa
====

My buildroot/cross build experiments

## Create cross compiler

### Install the tool that will create the cross compiler

Clone crosstool-ng sources, and check out a specific version, and install it:

    ./install_crosstool_ng.sh


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

## Try out the new system

    ./tryit.sh

## Clean out everything

    ./clean.sh

## Get crosstool-ng

This step is not yet automated, as I am only experimenting on how to set up
an external cross compiler.

    mkdir .ctng
    cd .ctng
    wget -qO - \
      http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.18.0.tar.bz2 \
      | tar xjf -
    cd crosstool-ng-1.18.0
    ./configure --prefix="$(cd ../.. && pwd)/ct"
    make
    make install
    export PATH="${PATH}:$(cd ../.. && pwd)/ct/bin"
    cd ../..
    mkdir tchain
    cd tchain
    # ct-ng help
    # ct-ng list-samples
    # ct-ng show-x86_64-unknown-linux-gnu
    ct-ng x86_64-unknown-linux-gnu
    mkdir /data/matelakat/crosstoolng
    mkdir /data/matelakat/crosstoolng/src
    ct-ng menuconfig
    # Set kernel version to 3.2.37 - uwsgi needs accept4()
    # Set glibc version to 2.17
    # Set gcc version to 4.7.2
    # Uncheck fortran and java
    # CT_LOCAL_TARBALLS_DIR="/data/matelakat/crosstoolng/src"
    # CT_PREFIX_DIR="/data/matelakat/crosstoolng/x-tools/${CT_TARGET}"
    # Set PPL version to 0.11.2
    # Set CLOOG version to 0.15.11
    # Set GDB version to 7.4.1
    ct-ng build.4
    # This took 43:42 to complete

## How to create the config patch

This is how you create a Buildroot origin patch

    diff -u  .workspace/buildroot-2013.05/package/Config.in.orig \
      .workspace/buildroot-2013.05/package/Config.in > package_config.patch

This is how you apply it

    patch -p 0 --forward < package_config.patch

## Fix crosstool-ng bug around glibc

    diff -u \
      ct/lib/ct-ng.1.18.0/scripts/build/libc/glibc-eglibc.sh-common.orig \
      ct/lib/ct-ng.1.18.0/scripts/build/libc/glibc-eglibc.sh-common > ctng.patch

Better to use this:

    wget -q http://crosstool-ng.org/hg/crosstool-ng/raw-rev/23099a88a139

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

## Get a kernel image

    wget -q http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.2.37-precise/linux-image-3.2.37-030237-virtual_3.2.37-030237.201301152335_amd64.deb
    ar vx linux-image-3.2.37-030237-virtual_3.2.37-030237.201301152335_amd64.deb
    tar -xjvf data.tar.bz2
    qemu-system-x86_64 \
      -kernel boot/vmlinuz-3.2.37-030237-virtual \
      -drive file=.workspace/buildroot-2013.05/output/images/rootfs.ext2 \
      -append root=/dev/sda

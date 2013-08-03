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
    ct-ng x86_64-unknown-linux-gnu
    mkdir /data/matelakat/crosstoolng
    mkdir /data/matelakat/crosstoolng/src
    # Edit .config
    # ML_BASE="/data/matelakat/crosstoolng"
    # CT_LOCAL_TARBALLS_DIR="${ML_BASE}/src"
    # CT_PREFIX_DIR="${ML_BASE}/x-tools/${CT_TARGET}"
    ct-ng build.2
    # This took 58:50.98 to complete

## How to create the config patch

This is how you create a Buildroot origin patch

    diff -u  .workspace/buildroot-2013.05/package/Config.in.orig \
      .workspace/buildroot-2013.05/package/Config.in > package_config.patch

This is how you apply it

    patch -p 0 --forward < package_config.patch

## Useful documents

 - http://osmz.mrl.cz/buildroot.html

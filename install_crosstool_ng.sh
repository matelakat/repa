#!/bin/bash

CTSRC=".crosstool-ng-src"

if ! [ -d .crosstool-ng-src ]; then
    hg clone http://crosstool-ng.org/hg/crosstool-ng/ "$CTSRC"
fi

(
  cd "$CTSRC"
  hg checkout 86a8d1d467c8
  ./bootstrap
  ./configure --prefix=$(cd .. && pwd)/.crosstool-ng
  make
  make install
)

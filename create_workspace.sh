#!/bin/bash

WORKSPACE=.workspace
BUILDROOT=http://buildroot.net/downloads/buildroot-2013.05.tar.gz

mkdir -p "$WORKSPACE"
wget -qO - $BUILDROOT | tar -xzf - -C "$WORKSPACE"

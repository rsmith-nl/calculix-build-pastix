#!/bin/sh
# file: 01_build_spooles.sh
# vim:fileencoding=utf-8:ft=sh
# Patch and build multithreaded spooles.
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-02-18T16:30:04+0100
# Last modified: 2024-04-24T13:49:05+0200

set -e

rm -rf source/spooles
mkdir -p source/spooles
cd source/spooles
tar xf ../../distfiles/spooles.2.2.tgz
patch -p0 <../../patches/spooles/patch-ETree+src+makeGlobalLib
patch -p0 <../../patches/spooles/patch-ETree+src+transform.c
patch -p0 <../../patches/spooles/patch-I2Ohash-large-input
patch -p0 <../../patches/spooles/patch-IVL+src+makeGlobalLib
patch -p0 <../../patches/spooles/patch-Make.inc
patch -p0 <../../patches/spooles/patch-MT+drivers+AllInOneMT.c
patch -p0 <../../patches/spooles/patch-Tree+src+makeGlobalLib
patch -p0 <../../patches/spooles/patch-Utilities+MM.h
patch -p0 <../../patches/spooles/patch-Utilities+src+makeGlobalLib
patch -p0 <../../patches/spooles/patch-Utilities+src+iohb.c
make global -f makefile
cd MT/src
make -f makeGlobalLib
# Do not remove; we'll use it here.

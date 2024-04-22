#!/bin/sh
# file: 01_build_spooles.sh
# vim:fileencoding=utf-8:ft=sh
# Patch and build multithreaded spooles.
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-02-18T16:30:04+0100
# Last modified: 2024-03-24T15:05:45+0100

set -e

mkdir -p source/spooles
cd source/spooles
tar xf ../../distfiles/spooles.2.2.tgz
patch <../../patches/spooles/patch-ETree+src+makeGlobalLib
patch <../../patches/spooles/patch-I2Ohash-large-input
patch <../../patches/spooles/patch-IVL+src+makeGlobalLib
patch <../../patches/spooles/patch-Make.inc
patch <../../patches/spooles/patch-MT+drivers+AllInOneMT.c
patch <../../patches/spooles/patch-Tree+src+makeGlobalLib
patch <../../patches/spooles/patch-Utilities+MM.h
patch <../../patches/spooles/patch-Utilities+src+makeGlobalLib
make global -f makefile
cd MT/src
make -f makeGlobalLib
# Do not remove; we'll use it here.

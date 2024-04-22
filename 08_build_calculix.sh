#!/bin/sh
# file: 08_build_calculix.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T14:21:00+0100
# Last modified: 2024-04-22T17:12:47+0200

set -e

# Unpack calculix
cd source
rm -rf ccx CalculiX
tar xf ../distfiles/ccx_2.21.src.tar.bz2
mv CalculiX/ccx_2.21/src ccx
rm -rf CalculiX

cd ccx
cp ../../patches/Makefile_RFS .
patch -p 1 < ../../patches/ccx/ccx_pastix.c.patch
gmake -f Makefile_RFS
strip ccx_2.21_i8
mv ccx_2.21_i8 ccx_i8
install -m 700 ccx_i8 ~/.local/bin

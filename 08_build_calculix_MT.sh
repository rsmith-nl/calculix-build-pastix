#!/bin/sh
# file: 08_build_calculix.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T14:21:00+0100
# Last modified: 2024-04-21T20:56:47+0200

set -e

# Unpack calculix
cd source
rm -rf ccx
tar xf ../distfiles/ccx_2.21.src.tar.bz2
mv CalculiX/ccx_2.21/src ccx
rm -rf CalculiX

cd ccx
cp ../../patches/Makefile_MT_RFS .
patch -p 1 < ../../patches/ccx/ccx_pastix.c.patch
gmake -f Makefile_MT_RFS
strip ccx_2.21_MT
mv ccx_2.21_MT ccx_mt
install -m 700 ccx_mt ~/.local/bin

#!/bin/sh
# file: 08b_build_calculix_spooles.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T14:21:00+0100
# Last modified: 2024-04-28T12:14:01+0200

# Build calculix with SPOOLES, OpenBLAS and ARPACK only.

set -e
PREFIX=`pwd`

cd source
rm -rf ccx
tar xf ../distfiles/ccx_2.21.src.tar.bz2
mv CalculiX/ccx_2.21/src ccx
rm -rf CalculiX

cd ccx
cp ../../patches/Makefile_MT_RFS .
gmake -f Makefile_MT_RFS
strip ccx_2.21_MT
mv ccx_2.21_MT ccx_spooles
install -m 700 ccx_spooles ${PREFIX}/bin
install -m 700 ccx_spooles ~/.local/bin
cd ..
rm -rf ccx

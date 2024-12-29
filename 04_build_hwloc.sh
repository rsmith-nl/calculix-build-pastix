#!/bin/sh
# file: 04_build_hwloc.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:41:52+0100
# Last modified: 2024-12-29T19:17:13+0100

set -e
PREFIX=`pwd`

cd source
rm -rf hwloc*
tar xf ../distfiles/hwloc-2.11.2.tar.gz
mv hwloc-hwloc-2.11.2 hwloc

cd hwloc
./autogen.sh
env CC=gcc13 CXX=g++13 LIBS='-lexecinfo -lpciaccess -lm'\
    ./configure \
    --prefix=${PREFIX} \
    --disable-shared --enable-static \
    --disable-readme --disable-picky --disable-cairo \
    --disable-libxml2 --disable-levelzero

#Result:
#-----------------------------------------------------------------------------
#Hwloc optional build support status (more details can be found above):
#
#Probe / display I/O devices: PCI(pciaccess)
#Graphical output:            no
#XML input / output:          basic
#Plugin support:              no
#-----------------------------------------------------------------------------

gmake -j4
gmake install
cd ..
rm -rf hwloc

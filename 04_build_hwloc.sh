#!/bin/sh
# file: 04_build_hwloc.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:41:52+0100
# Last modified: 2024-04-24T14:23:47+0200

set -e
PREFIX=`pwd`

cd source
rm -rf hwloc*
tar xf ../distfiles/hwloc-2.10.0.tar.bz2
mv hwloc-2.10.0 hwloc

cd hwloc
env CC=gcc13 CXX=g++13 LIBS='-lexecinfo -lpciaccess'\
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

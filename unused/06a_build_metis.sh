#!/bin/sh
# file: 06a_build_metis.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-04-23T13:54:12+0200
# Last modified: 2024-04-23T14:57:33+0200

set -e

cd source
rm -rf metis
tar xf ../distfiles/metis-5.1.0.tar.gz
mv metis-5.1.0 metis
cd metis

patch -p0 < ../../patches/metis/patch-CMakeLists.txt
patch -p0 < ../../patches/metis/patch-libmetis__CMakeLists.txt
patch -p0 < ../../patches/metis/patch-programs_CMakeLists.txt
patch -p0 < ../../patches/metis/patch-include-metis.h
gmake config \
    cc=gcc13 prefix=/zstorage/home/rsmith/tmp/src/calculix-build \
    LDFLAGS=-lexecinfo
gmake
gmake install
cd ..
rm -rf metis

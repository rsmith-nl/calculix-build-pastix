#!/bin/sh
# file: 06a_build_metis.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-04-23T13:54:12+0200
# Last modified: 2024-04-23T23:25:47+0200

set -e

cd source

# Needed to build METIS.
rm -rf GKlib
tar xf ../distfiles/GKlib-METIS-v5.1.1-DistDGL-0.5.tar.gz
mv GKlib-METIS-v5.1.1-DistDGL-0.5 GKlib
cd GKlib
gmake config \
    cc=gcc13 prefix=/zstorage/home/rsmith/tmp/src/calculix-build \
    LDFLAGS=-lexecinfo
gmake install
cd ..
rm -rf GKlib

rm -rf metis
tar xf ../distfiles/METIS-5.2.1.tar.gz
mv METIS-5.2.1 metis
cd metis

echo 'target_link_libraries(metis PUBLIC "-lGKlib")' >> libmetis/CMakeLists.txt
# Do not build the programs.
sed -i '' -e '/programs/d' CMakeLists.txt

#patch < ../../patches/metis/patch-CMakeLists.txt
#patch < ../../patches/metis/patch-libmetis__CMakeLists.txt
#patch < ../../patches/metis/patch-programs_CMakeLists.txt
#patch < ../../patches/metis/patch-include-metis.h
gmake config \
    cc=gcc13 prefix=/zstorage/home/rsmith/tmp/src/calculix-build \
    i64=1 \
    LDFLAGS=-lexecinfo
gmake
gmake install
cd ..
rm -rf metis

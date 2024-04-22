#!/bin/sh
# file: 07_build_pastix.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:42:32+0100
# Last modified: 2024-04-12T02:14:56+0200

set -e

cd source
rm -rf pastix
tar xf ../distfiles/pastix-6.2.0.tar.gz
mv pastix-6.2.0 pastix
cd pastix

patch -p 1 < ../../patches/pastix-6.2/calculix-fix.patch

mkdir build
cd build
env PKG_CONFIG_PATH=/zstorage/home/rsmith/tmp/src/calculix-build/lib/pkgconfig \
cmake   -Wno-dev \
        -DPASTIX_INT64=ON \
        -DPASTIX_WITH_CUDA=OFF \
        -DLAPACKE_WITH_TMG=OFF \
        -DCMAKE_PREFIX_PATH=/zstorage/home/rsmith/tmp/src/calculix-build \
        -DCMAKE_INSTALL_PREFIX=/zstorage/home/rsmith/tmp/src/calculix-build \
        -DCMAKE_BUILD_TYPE=Release \
        -DPASTIX_WITH_PARSEC=ON \
        -DSCOTCH_DIR=/zstorage/home/rsmith/tmp/src/calculix-build \
        -DPASTIX_ORDERING_SCOTCH=ON \
        -DCMAKE_C_COMPILER=gcc13 \
        -DCMAKE_CXX_COMPILER=g++13 \
        -DCMAKE_Fortran_COMPILER=gfortran13 \
        -DCMAKE_C_FLAGS='-fopenmp -lpciaccess -lm -Wno-unused-parameter' \
        ..
gmake -j4
gmake install
cd ../..
rm -rf pastix

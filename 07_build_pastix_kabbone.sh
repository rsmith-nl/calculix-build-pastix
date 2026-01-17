#!/bin/sh
# file: 07_build_pastix.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:42:32+0100
# Last modified: 2026-01-17T10:29:51+0100

set -e
PREFIX=`pwd`

# This build *requires* Python 2.7.
# The code generation scripts in this version of PaStiX do *not* work with
# python 3!
if ! which python2.7 >/dev/null; then
        echo "Python 2.7 not found."
        echo "It is required for building this version of pastix. Exiting..."
        exit 1
fi

cd source
rm -rf pastix
tar xf ../distfiles/PaStiX4CalculiX-2.17_cudaless.tar.gz
mv PaStiX4CalculiX-2.17_cudaless pastix4calculix
cd pastix4calculix

patch < ../../patches/pastix/kabbone-CMakeLists.txt.patch
patch < ../../patches/pastix/spm.c.patch
patch < ../../patches/pastix/bcsc_z.h.patch

mkdir build
cd build
env PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig \
cmake   -Wno-dev \
        -DPYTHON_EXECUTABLE=/usr/local/bin/python2.7 \
        -DPASTIX_WITH_CUDA=OFF \
        -DCMAKE_PREFIX_PATH=${PREFIX} \
        -DCMAKE_INSTALL_PREFIX=${PREFIX} \
        -DCMAKE_BUILD_TYPE=Release \
        -DPASTIX_WITH_PARSEC=ON \
        -DSCOTCH_DIR=${PREFIX} \
        -DPASTIX_ORDERING_SCOTCH=ON \
        -DCMAKE_C_COMPILER=gcc13 \
        -DCMAKE_CXX_COMPILER=g++13 \
        -DCMAKE_Fortran_COMPILER=gfortran13 \
        -DCMAKE_C_FLAGS='-fopenmp -lpciaccess -lm -Wno-unused-parameter' \
        ..
gmake -j4
gmake install
cd ../..
rm -rf pastix4calculix

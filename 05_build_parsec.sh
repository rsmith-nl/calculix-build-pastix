#!/bin/sh
# file: 05_build_parsec.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:42:10+0100
# Last modified: 2024-04-24T14:30:09+0200

set -e
PREFIX=`pwd`

cd source
rm -rf *parsec*
tar xf ../distfiles/mfaverge-parsec-b580d208094e.tar.gz
mv mfaverge-parsec-b580d208094e parsec
cd parsec
# Fix location of unistd.h
sed -i '.orig' -e 's/linux\/unistd.h/unistd.h/' parsec/scheduling.c
# Fix missing alloca.h
sed -i '.orig' -e 's/alloca\.h/stdlib.h/' parsec/interfaces/ptg/ptg-compiler/jdf2c.c

patch < ../../patches/parsec/bindthread.c.patch

mkdir build
cd build

cmake \
    -Wno-dev \
    -DEXTRA_LIBS='-lexecinfo -lpciaccess' \
    -DNO_CMAKE_SYSTEM_PATH=YES \
    -DCMAKE_INSTALL_LOCAL_ONLY=YES \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_CXX_COMPILER=g++13 \
    -DCMAKE_C_COMPILER=gcc13 \
    -DCMAKE_Fortran_COMPILER=gfortran13 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DPARSEC_GPU_WITH_CUDA=OFF \
    -DHWLOC_DIR=${PREFIX} \
    ..


gmake -j4
# Disable Python extension.
sed -i '.orig' -e '/include.*python/d' tools/profiling/cmake_install.cmake
gmake install
cd ../../
rm -rf parsec

#!/bin/sh
# file: 05_build_parsec.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:42:10+0100
# Last modified: 2024-04-22T02:06:09+0200

set -e

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
    -DCMAKE_INSTALL_PREFIX=/zstorage/home/rsmith/tmp/src/calculix-build \
    -DPARSEC_GPU_WITH_CUDA=OFF \
    -DHWLOC_DIR=/zstorage/home/rsmith/tmp/src/calculix-build \
    ..

#Configuration flags:
#  CMAKE_C_FLAGS          =  -m64 -std=c1x
#  CMAKE_C_LDFLAGS        =  -m64
#  CMAKE_EXE_LINKER_FLAGS = 
#  EXTRA_LIBS             = -lexecinfo -lpciaccess;-latomic;-lpthread;/home/rsmith/tmp/src/calculix-build/lib/libhwloc.a;-L/usr/local/lib/gcc13/gcc/x86_64-portbld-freebsd14.0/12.2.0;-L/usr/local/x86_64-portbld-freebsd14.0/lib;-L/usr/local/lib/gcc13;gfortran;m;gcc;gcc_s;quadmath;m;gcc;gcc_s;c;gcc;gcc_s

gmake -j4
# Disable Python extension.
sed -i '.orig' -e '/include.*python/d' tools/profiling/cmake_install.cmake
gmake install
cd ../../
rm -rf parsec

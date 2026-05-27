#!/bin/sh
# file: 03_build_openblas.sh
# vim:fileencoding=utf-8:ft=sh
# Build OpenBLAS
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-02-18T16:43:42+0100
# Last modified: 2026-05-27T10:20:03+0200

set -e
PREFIX=`pwd`
# for testing
#echo "PREFIX is set to “${PREFIX}”"
#sleep 1

cd source
rm -rf OpenBLAS
tar xf ../distfiles/OpenBLAS-0.3.31.tar.gz
mv OpenBLAS-0.3.31 OpenBLAS

cd OpenBLAS
# Do *not* use USE_OPENMP=1. Pastix needs a singe-threaded build, hence USE_THREAD=0.
# Enable locking in case BLAS routines are called in a multithreaded program.
# Use DYNAMIC_ARCH=1 to build for all CPU architecture variants.
# For a machine with 32 GiB of ram, use BUFFERSIZE=25.
# For a machine with 8 GiB, use BUFFERSIZE=22.
env CC=gcc13 FC=gfortran13 AR=gcc-ar13 \
    PREFIX=${PREFIX} \
    NO_SHARED=1 INTERFACE64=1 BINARY=64 USE_THREAD=0 \
    BUFFERSIZE=22 USE_LOCKING=1 DYNAMIC_ARCH=0 \
    gmake

env CC=gcc13 FC=gfortran13 AR=gcc-ar13 \
    PREFIX=${PREFIX} \
    NO_SHARED=1 INTERFACE64=1 BINARY=64 USE_THREAD=0 \
    BUFFERSIZE=22 USE_LOCKING=1 DYNAMIC_ARCH=0 \
    gmake install
cd ..
rm -rf OpenBLAS

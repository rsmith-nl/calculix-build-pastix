#!/bin/sh
# file: 03_build_openblas.sh
# vim:fileencoding=utf-8:ft=sh
# Build OpenBLAS
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-02-18T16:43:42+0100
# Last modified: 2025-11-09T18:50:17+0100

set -e
PREFIX=`pwd`
# for testing
#echo "PREFIX is set to “${PREFIX}”"
#sleep 1

cd source
rm -rf OpenBLAS
tar xf ../distfiles/OpenBLAS-0.3.30.tar.gz
mv OpenBLAS-0.3.30 OpenBLAS

cd OpenBLAS
# Do *not* use USE_OPENMP=1. Pastix needs a singe-threaded build, hence USE_THREAD=0.
# Enable locking in case BLAS routines are called in a multithreaded program.
env CC=gcc13 FC=gfortran13 AR=gcc-ar13 \
    PREFIX=${PREFIX} \
    NO_SHARED=1 INTERFACE64=1 BINARY=64 USE_THREAD=0 \
    BUFFERSIZE=25 USE_LOCKING=1 DYNAMIC_ARCH=1 \
    gmake

env CC=gcc13 FC=gfortran13 AR=gcc-ar13 \
    PREFIX=${PREFIX} \
    NO_SHARED=1 INTERFACE64=1 BINARY=64 USE_THREAD=0 \
    BUFFERSIZE=25 USE_LOCKING=1 DYNAMIC_ARCH=1 \
    gmake install
cd ..
rm -rf OpenBLAS

# OpenBLAS build complete. (BLAS CBLAS LAPACK LAPACKE)
#
#  OS               ... FreeBSD
#  Architecture     ... x86_64
#  BINARY           ... 64bit
#  Use 64 bits int    (equivalent to "-i8" in Fortran)
#  C compiler       ... GCC  (cmd & version : gcc13 (FreeBSD Ports Collection) 13.3.0)
#  Fortran compiler ... GFORTRAN  (cmd & version : GNU Fortran (FreeBSD Ports Collection) 13.3.0)
#  Library Name     ... libopenblas-r0.3.30.a (Single-threading)
#  Supporting multiple x86_64 cpu models with minimum requirement for the common code being HASWELL

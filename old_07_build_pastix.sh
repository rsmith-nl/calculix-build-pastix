#!/bin/sh
# file: 07_build_pastix.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:42:32+0100
# Last modified: 2024-03-24T15:33:01+0100

set -e

cd source
rm -rf PaStiX*
tar xf ../distfiles/PaStiX4CalculiX-ccx_2.18.tar.gz
mv PaStiX4CalculiX-ccx_2.18 PaStiX
cd PaStiX

sed -i '.orig' -e '/Bad replacement pair/d' -e '/import imp;/d' cmake_modules/morse_cmake/modules/precision_generator/*.py spm/cmake_modules/morse_cmake/modules/precision_generator/*.py

patch < ../../patches/pastix/api.c.patch
patch < ../../patches/pastix/bcsc_z.h.patch
patch < ../../patches/pastix/bcsc_zinit.c.patch
patch < ../../patches/pastix/bvec_zcompute.c.patch
patch < ../../patches/pastix/bvec.c.patch
patch < ../../patches/pastix/CMakeLists.txt.patch
patch < ../../patches/pastix/coeftab.h.patch
patch < ../../patches/pastix/cpu_z_spmv.h.patch
patch < ../../patches/pastix/gpu_z_spmv.h.patch
patch < ../../patches/pastix/pastix_task_refine.c.patch
patch < ../../patches/pastix/pastix_task_solve.c.patch
patch < ../../patches/pastix/pastix_task_sopalin.c.patch
patch < ../../patches/pastix/patixdata.h.patch
patch < ../../patches/pastix/sopalin_data.h.patch
patch < ../../patches/pastix/spm.c.patch
patch < ../../patches/pastix/z_refine_gmres_gpu.c.patch
sed -i '.orig' -e '/cublasHandle_t/d' -e '/cublasStatus_t/d' -e '/cublas_v2\.h/d' sopalin/parsec/*.jdf

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
rm -rf PaStiX

#!/bin/sh
# file: 03_build_arpack.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-15T15:21:42+0100
# Last modified: 2024-04-22T22:53:09+0200

set -e

cd source
rm -rf arpack*
tar xf ../distfiles/arpack-ng-3.9.1.tar.gz
mv arpack-ng-3.9.1 arpack

# Build arpack.
cd arpack
autoreconf -vif
env INTERFACE64=1 CC=gcc13 F77=gfortran13 FC=gfortran13 \
    LDFLAGS=-L/home/rsmith/tmp/src/calculix-build \
./configure --with-blas=-lopenblas --with-lapack=-lopenblas --enable-icb --enable-static --disable-shared --prefix=/home/rsmith/tmp/src/calculix-build/
gmake
gmake install
cd ..
rm -rf arpack

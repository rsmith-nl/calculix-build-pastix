#!/bin/sh
# file: 06_build_scotch.sh
# vim:fileencoding=utf-8:ft=sh
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-03-23T11:42:22+0100
# Last modified: 2024-04-24T14:49:53+0200

set -e
PREFIX=`pwd`

cd source
rm -rf scotch*
tar xf ../distfiles/scotch-v6.0.8.tar.gz
mv scotch-v6.0.8 scotch
cd scotch/src
cp ../../../patches/scotch/Makefile.inc.RFS Makefile.inc
gmake libscotch
gmake esmumps
env prefix=${PREFIX} gmake install
cd ../..
# rm -rf scotch

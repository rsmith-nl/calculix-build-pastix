#!/bin/sh
# file: clean.sh
# vim:fileencoding=utf-8:ft=sh
# Prepare the build and result directories.
#
# Author: R.F. Smith <rsmith@xs4all.nl>
# Created: 2024-04-24T13:43:36+0200
# Last modified: 2024-04-24T13:45:13+0200

rm -rf source
rm -rf bin examples share lib libexec include
mkdir source
mkdir bin examples share lib libexec include

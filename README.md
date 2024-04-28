# Building CalculiX (with PaStiX without CUDA) on FreeBSD

## Introduction

Because of the limitations of the spooles solver library, and because it is
supposed to be really fast, I wanted to build the calculix solver `ccx` with
the PaStiX solver library.

Since I prefer free software graphics drivers, my computers do not have NVIDIA
graphics cards.
Additionally, NVIDIA doesn't offer CUDA on FreeBSD.

So I needed to build PaStiX without CUDA.
This process turned out to be somewhat complicated, that is why I'm
documenting it here.

Currently, CalculiX used a modified version of PaStiX that you can find at
https://github.com/Dhondtguido/PaStiX4CalculiX.
This is based on an older version of PaStiX. And even though it has
a confifuration option to build without CUDA, that doesn't work.
Basically, even if you switch CUDA off, there is still some CUDA-specific
stuff left.
I was halfway through patching all that, when I found that github user Kabbone
had already done all of that:
https://github.com/Kabbone/PaStiX4CalculiX/tree/cudaless.
So that is the version I'm using.

All the distribution files of known working versions are stored in
`distfiles` directory.
The `patches` directory contains some patches to fix warnings and errors.
The patches for spooles are mostly from the FreeBSD ports tree, although I've
added a couple of my own.
One of the patches for `ccx` was borrowed from the Arch Linux repo.
Most of the other patches are my work.

## License

The files in `distfiles` are under their respective licences.
The materials that I wrote are hereby placed in the public domain.

## Prerequisites

The first prerequisite is a UNIX-like operating system.
These instructions are geared towards building CalculiX on a FreeBSD UNIX
workstation.
They can probably be used with some modifications on a Linux machine.
Personally I don't use ms-windows, and since that OS lacks basically all the
tools needed, these scripts won't work there as-is.

The second prerequisite is a development environment.
More specifically;

* GNU make (called `gmake` on FreeBSD, usually `make` on Linux)
* A Fortran compiler. Here GNU fortran in the form of `gfortran13` is used.
  (On Linux it's probably just called `gfortran`)
* A C compiler. Here `gcc13` is used. (or `gcc` on Linux)
* GNU autotools/automake/libtool
* cmake
* bison
* Python 2.7 (for PaStiX code expansion)
* Python 3


## Running the build

The build is done in steps, each captured in a shell script.

It is important that the shell scripts are started from the directory they
reside in!

First step is to clean up, to remove any remains from a previous build.
Having old or other versions of include files around can cause a real
headache.
So in case of doubt, start with a clean sheet.

```
sh 00_clean.sh
```

First step is to build spooles. Basically all the following scripts are called
in the same way, to also capture output in a logfile for later examination in
case of problems.

Note that I'm using `tcsh` here. In other shells the syntax for also
redirecting standard error output (`|&`) will be different.
The `tee` program allows you to see the progression of the build while also
saving it in the log file.

```
sh 01_build_spooles.sh |& tee logfiles/spooles.log
```

The next step is to build OpenBLAS.
If you want to make the build faster and the library smaller, remove the
`DYNAMIC_ARCH=1` flag.
This will build an OpenBLAS library *specific* to the CPU family you're building
the library on.

Note that even though threads are disabled, it is **critical** that
`USE_LOCKING=1` is used, because CalculiX *is* using multiple threads.

Also the buffer size is increased to 1 GiB, up from the default 32 MiB.

```
sh 02_build_openblas.sh |& tee logfiles/openblas.log
```

Next is building ARPACK.

```
sh 03_build_arpack.sh | & tee logfiles/arpack.log
```

If you just want to build ccx just with SPOOLES and ARPACK, you can now run
the following command and then the build is finished.

```
sh 08a_build_calculix_pastix.sh | & tee logfiles/calculix.log
```

To continue the build with PaStix, now is the time to build hwloc.
For me it was necessary to explicitly add `libexecinfo` and `libpciaccess` to
the configuration. YMMV.

```
sh 04_build_hwloc.sh|& tee logfiles/hwloc.log
```

Building PaRSEC required me to fix the location of some include files.
This is done in the shell-script using `sed`.
These commands can probably be commented out on Linux.
If not, they need to be adapted since GNU sed is slightly different in its use
of the `-i` option.

```
sh 05_build_parsec.sh|& tee logfiles/parsec.log
```

The next step is to build the scotch ordering library.
(I could not get metis to build with PaStiX, and scotch is supposed to be
faster.)
If your CPU has more or less than 4 cores, you might want to change
`-DSCOTCH_PTHREAD_NUMBER=4` in `patches/scotch/Makefile.inc.RFS` accordingly.

```
sh 06_build_scotch.sh | & tee logfiles/scotch.log
```

Now comes building the PaStiX solver itself.
Note that you will have to adapt the shell-script if Python 2.7 is not in
`/usr/local/bin/python2.7`.

```
sh 07_build_pastix_kabbone.sh | & tee logfiles/pastix.log
```

And finally it is time to build the CalculiX solver itself.
The script installs this version as `ccx_i8` in `~/.local/bin`.
Comment this out or change it if you want to put it somewhere else.

```
sh 08a_build_calculix_pastix.sh | & tee logfiles/calculix.log
```

That's it.

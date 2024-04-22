--- Make.inc.orig	1999-01-18 22:48:55.000000000 +0100
+++ Make.inc	2024-03-24 01:04:57.444024000 +0100
@@ -12,7 +12,8 @@
 # for solaris
 #
 # CC = gcc
-  CC = /usr/lang-4.0/bin/cc
+# CC = /usr/lang-4.0/bin/cc
+CC = gcc13
 #
 # for sgi
 #
@@ -28,14 +29,14 @@
 # 
 # OPTLEVEL = 
 # OPTLEVEL = -g -v
-  OPTLEVEL = -O
+# OPTLEVEL = -O
 # OPTLEVEL = -xO5 -v
-# OPTLEVEL = -O3
+OPTLEVEL = -O3
 # OPTLEVEL = -O4
 # CFLAGS = -Wall -g
 # CFLAGS = -Wall -pg
 # CFLAGS = $(OPTLEVEL) -D_POSIX_C_SOURCE=199506L
-  CFLAGS = $(OPTLEVEL)
+CFLAGS += $(OPTLEVEL)
 # CFLAGS = -Wall $(OPTLEVEL)
 #
 #----------------------------------------
@@ -51,27 +52,27 @@
 #
 # THREAD_LIBS =
 # THREAD_LIBS = -D_REENTRANT=199506L -lpthread
-  THREAD_LIBS = -D_POSIX_C_SOURCE=199506L -lpthread
+THREAD_LIBS = -D_POSIX_C_SOURCE=199506L -lpthread
 # THREAD_LIBS = -lpthread
 #
 #---------------------------------------------------------------------
 #
 #  set the purify environment (a memory monitoring tool)
 #
-  PURIFY = 
+# PURIFY = 
 # PURIFY = /usr/local/purify-4.0.1/purify
 #
 #  purify wouldn't work with the newest version of the gcc library,
 #  so we had to force loading the old version
 #
-  PURIFY_GCC_VERSION = 
+# PURIFY_GCC_VERSION = 
 # PURIFY_GCC_VERSION = -V 2.7.2
 #
 #---------------------------------------------------------------------
 #
 #  set the archive flags
 #
-  AR = ar
+  AR = gcc-ar13
   ARFLAGS = rv
 #
 #---------------------------------------------------------------------
@@ -79,22 +80,22 @@
 #  set the ranlib environment
 #  (if ranlib is not needed, we echo the library name)
 #
-# RANLIB = ranlib
-  RANLIB = echo
+RANLIB = gcc-ranlib13
+# RANLIB = echo
 #
 #---------------------------------------------------------------------
 #
 #  set suffix rule *.c --> *.o
 #
-.c.o : 
-	$(PURIFY) $(CC) -c $(CFLAGS) $<
+#.c.o : 
+#	$(PURIFY) $(CC) -c $(CFLAGS) $<
 #
 #---------------------------------------------------------------------
 #
 #  set suffix rule *.c --> *.a
 #
 .c.a : 
-	$(PURIFY) $(CC) -c $(CFLAGS) $<
+	$(CC) -c $(CFLAGS) $<
 	$(AR) $(ARFLAGS) $@ $*.o
 	rm -f $*.o
 #
@@ -103,7 +104,7 @@
 #  MPI install library
 #
 # MPI_INSTALL_DIR = 
-  MPI_INSTALL_DIR = /usr/local/mpich-1.0.13
+#  MPI_INSTALL_DIR = /usr/local/mpich-1.0.13
 #
 #---------------------------------------------------------------------
 #
@@ -115,7 +116,7 @@
 #
 # for solaris
 #
-  MPI_LIB_PATH = -L$(MPI_INSTALL_DIR)/lib/solaris/ch_p4
+# MPI_LIB_PATH = -L$(MPI_INSTALL_DIR)/lib/solaris/ch_p4
 #
 # for hp
 #
@@ -127,7 +128,7 @@
 #
 # for solaris
 #
-  MPI_LIBS = $(MPI_LIB_PATH) -D_REENTRANT -lmpi -lsocket -lnsl -lthread
+# MPI_LIBS = $(MPI_LIB_PATH) -D_REENTRANT -lmpi -lsocket -lnsl -lthread
 #
 # for sgi
 #
@@ -142,6 +143,6 @@
 #  MPI include path
 #
 # MPI_INCLUDE_DIR = 
-  MPI_INCLUDE_DIR = -I$(MPI_INSTALL_DIR)/include
+# MPI_INCLUDE_DIR = -I$(MPI_INSTALL_DIR)/include
 #
 #---------------------------------------------------------------------

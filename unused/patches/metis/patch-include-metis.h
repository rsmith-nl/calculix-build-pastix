--- include/metis.h.orig	2024-04-23 14:55:45.397781000 +0200
+++ include/metis.h	2024-04-23 14:56:09.315665000 +0200
@@ -30,7 +30,7 @@
  GCC does provides these definitions in stdint.h, but it may require some
  modifications on other architectures.
 --------------------------------------------------------------------------*/
-#define IDXTYPEWIDTH 32
+#define IDXTYPEWIDTH 64
 
 
 /*--------------------------------------------------------------------------

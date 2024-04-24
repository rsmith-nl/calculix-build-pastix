--- ETree/src/transform.c.orig	2024-04-24 09:28:31.773050000 +0200
+++ ETree/src/transform.c	2024-04-24 09:30:59.964470000 +0200
@@ -291,7 +291,7 @@
    remap the nzeros[] vector
    -------------------------
 */
-temp = IVinit(nfront, NULL) ;
+temp = IVinit(nfront, 0) ;
 IVcopy(nfront, temp, nzeros) ;
 IV_setSize(nzerosIV, nnew) ;
 nzeros = IV_entries(nzerosIV) ;
@@ -453,7 +453,7 @@
    remap the nzeros[] vector
    -------------------------
 */
-temp = IVinit(nfront, NULL) ;
+temp = IVinit(nfront, 0) ;
 IVcopy(nfront, temp, nzeros) ;
 IV_setSize(nzerosIV, nnew) ;
 nzeros = IV_entries(nzerosIV) ;
@@ -614,7 +614,7 @@
    remap the nzeros[] vector
    -------------------------
 */
-temp = IVinit(nfront, NULL) ;
+temp = IVinit(nfront, 0) ;
 IVcopy(nfront, temp, nzeros) ;
 IV_setSize(nzerosIV, nnew) ;
 nzeros = IV_entries(nzerosIV) ;

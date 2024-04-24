--- Utilities/src/iohb.c.orig	1998-09-19 16:35:21.000000000 +0200
+++ Utilities/src/iohb.c	2024-04-24 09:41:20.830552000 +0200
@@ -266,7 +266,7 @@
                   &Ptrcrd, &Indcrd, &Valcrd, &Rhscrd, Rhstype);
     fclose(in_file);
     *Type = mat_type;
-    *(*Type+3) = (char) NULL;
+    *(*Type+3) = (char) 0;
     *M    = Nrow;
     *N    = Ncol;
     *nz   = Nnzero;
@@ -308,8 +308,8 @@
     if ( sscanf(line,"%*s") < 0 ) 
         IOHBTerminate("iohb.c: Null (or blank) first line of HB file.\n");
     (void) sscanf(line, "%72c%8[^\n]", Title, Key);
-    *(Key+8) = (char) NULL;
-    *(Title+72) = (char) NULL;
+    *(Key+8) = (char) 0;
+    *(Title+72) = (char) 0;
 
 /*  Second line:  */
     fgets(line, BUFSIZ, in_file);
@@ -344,10 +344,10 @@
     if ( sscanf(line, "%*16c%*16c%20c",Valfmt) != 1) 
         IOHBTerminate("iohb.c: Invalid format info, line 4 of Harwell-Boeing file.\n"); 
     sscanf(line, "%*16c%*16c%*20c%20c",Rhsfmt);
-    *(Ptrfmt+16) = (char) NULL;
-    *(Indfmt+16) = (char) NULL;
-    *(Valfmt+20) = (char) NULL;
-    *(Rhsfmt+20) = (char) NULL;
+    *(Ptrfmt+16) = (char) 0;
+    *(Indfmt+16) = (char) 0;
+    *(Valfmt+20) = (char) 0;
+    *(Rhsfmt+20) = (char) 0;
    
 /*  (Optional) Fifth line: */
     if (*Rhscrd != 0 )
@@ -454,7 +454,7 @@
 
     ThisElement = (char *) malloc(Ptrwidth+1);
     if ( ThisElement == NULL ) IOHBTerminate("Insufficient memory for ThisElement.");
-    *(ThisElement+Ptrwidth) = (char) NULL;
+    *(ThisElement+Ptrwidth) = (char) 0;
     count=0;
     for (i=0;i<Ptrcrd;i++)
     {
@@ -477,7 +477,7 @@
 
     ThisElement = (char *) malloc(Indwidth+1);
     if ( ThisElement == NULL ) IOHBTerminate("Insufficient memory for ThisElement.");
-    *(ThisElement+Indwidth) = (char) NULL;
+    *(ThisElement+Indwidth) = (char) 0;
     count = 0;
     for (i=0;i<Indcrd;i++)
     {
@@ -505,7 +505,7 @@
 
     ThisElement = (char *) malloc(Valwidth+1);
     if ( ThisElement == NULL ) IOHBTerminate("Insufficient memory for ThisElement.");
-    *(ThisElement+Valwidth) = (char) NULL;
+    *(ThisElement+Valwidth) = (char) 0;
     count = 0;
     for (i=0;i<Valcrd;i++)
     {
@@ -705,7 +705,7 @@
 
   ThisElement = (char *) malloc(Rhswidth+1);
   if ( ThisElement == NULL ) IOHBTerminate("Insufficient memory for ThisElement.");
-  *(ThisElement+Rhswidth) = (char) NULL;
+  *(ThisElement+Rhswidth) = (char) 0;
   for (rhsi=0;rhsi<Nrhs;rhsi++) {
 
     for (i=0;i<Nentries;i++) {
@@ -1018,7 +1018,7 @@
 
     ThisElement = (char *) malloc(Ptrwidth+1);
     if ( ThisElement == NULL ) IOHBTerminate("Insufficient memory for ThisElement.");
-    *(ThisElement+Ptrwidth) = (char) NULL;
+    *(ThisElement+Ptrwidth) = (char) 0;
     count=0; 
     for (i=0;i<Ptrcrd;i++)
     {
@@ -1041,7 +1041,7 @@
 
     ThisElement = (char *) malloc(Indwidth+1);
     if ( ThisElement == NULL ) IOHBTerminate("Insufficient memory for ThisElement.");
-    *(ThisElement+Indwidth) = (char) NULL;
+    *(ThisElement+Indwidth) = (char) 0;
     count = 0;
     for (i=0;i<Indcrd;i++)
     {
@@ -1069,7 +1069,7 @@
 
     ThisElement = (char *) malloc(Valwidth+1);
     if ( ThisElement == NULL ) IOHBTerminate("Insufficient memory for ThisElement.");
-    *(ThisElement+Valwidth) = (char) NULL;
+    *(ThisElement+Valwidth) = (char) 0;
     count = 0;
     for (i=0;i<Valcrd;i++)
     {
@@ -1629,7 +1629,7 @@
        while ( strchr(tmp2+1,')') != NULL ) {
           tmp2 = strchr(tmp2+1,')');
        }
-       *(tmp2+1) = (int) NULL;
+       *(tmp2+1) = (int) 0;
     }
     if (strchr(fmt,'P') != NULL)  /* Remove any scaling factor, which */
     {                             /* affects output only, not input */
@@ -1639,11 +1639,11 @@
         tmp3 = strchr(fmt,'(')+1;
         len = tmp-tmp3;
         tmp2 = tmp3;
-        while ( *(tmp2+len) != (int) NULL ) {
+        while ( *(tmp2+len) != (int) 0 ) {
            *tmp2=*(tmp2+len);
            tmp2++; 
         }
-        *(strchr(fmt,')')+1) = (int) NULL;
+        *(strchr(fmt,')')+1) = (int) 0;
       }
     }
     if (strchr(fmt,'E') != NULL) { 
@@ -1706,7 +1706,7 @@
     SubS = (char *)malloc(len+1);
     if ( SubS == NULL ) IOHBTerminate("Insufficient memory for SubS.");
     for (i=0;i<len;i++) SubS[i] = S[pos+i];
-    SubS[len] = (char) NULL;
+    SubS[len] = (char) 0;
     } else {
       SubS = NULL;
     }

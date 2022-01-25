--- src/d8-posix.cc.orig	2018-08-28 22:00:10.000000000 +0200
+++ src/d8-posix.cc	2021-12-17 09:00:37.234274000 +0100
@@ -4,6 +4,8 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <sys/types.h>
+#include <netinet/in.h>
 #include <netinet/ip.h>
 #include <signal.h>
 #include <stdlib.h>

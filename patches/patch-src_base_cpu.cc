--- src/base/cpu.cc.orig	2018-08-28 22:00:10.000000000 +0200
+++ src/base/cpu.cc	2021-12-16 22:51:49.763883000 +0100
@@ -424,6 +424,7 @@ CPU::CPU()
 
 #if V8_OS_LINUX
 
+#if V8_OS_LINUX
   CPUInfo cpu_info;
 
   // Extract implementor from the "CPU implementer" field.
@@ -457,6 +458,7 @@ CPU::CPU()
     }
     delete[] part;
   }
+#endif
 
   // Extract architecture from the "CPU Architecture" field.
   // The list is well-known, unlike the the output of

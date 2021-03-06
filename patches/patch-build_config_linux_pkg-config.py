--- build/config/linux/pkg-config.py.orig	2021-12-16 22:49:58.000000000 +0100
+++ build/config/linux/pkg-config.py	2021-12-16 22:51:49.752310000 +0100
@@ -57,8 +57,12 @@ def SetConfigPath(options):
     print "You must specify an architecture via -a if using a sysroot."
     sys.exit(1)
 
-  libdir = sysroot + '/usr/' + options.system_libdir + '/pkgconfig'
-  libdir += ':' + sysroot + '/usr/share/pkgconfig'
+  if "linux" in sys.platform:
+    libdir = sysroot + '/libdata/' + options.system_libdir + '/pkgconfig'
+    libdir += ':' + sysroot + '/usr/share/pkgconfig'
+  elif "bsd" in sys.platform:
+    libdir = sysroot + '/libdata/pkgconfig'
+    libdir += ':' + '/usr/libdata/pkgconfig'
   os.environ['PKG_CONFIG_LIBDIR'] = libdir
   return libdir
 
@@ -107,7 +111,7 @@ def main():
   # If this is run on non-Linux platforms, just return nothing and indicate
   # success. This allows us to "kind of emulate" a Linux build from other
   # platforms.
-  if "linux" not in sys.platform:
+  if "bsd" not in sys.platform:
     print "[[],[],[],[],[]]"
     return 0
 

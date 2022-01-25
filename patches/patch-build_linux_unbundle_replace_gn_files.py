--- build/linux/unbundle/replace_gn_files.py.orig	2021-12-16 22:49:58.000000000 +0100
+++ build/linux/unbundle/replace_gn_files.py	2021-12-16 22:51:49.756738000 +0100
@@ -27,6 +27,7 @@ REPLACEMENTS = {
   'libevent': 'base/third_party/libevent/BUILD.gn',
   'libjpeg': 'third_party/libjpeg.gni',
   'libpng': 'third_party/libpng/BUILD.gn',
+  'libusb': 'third_party/libusb/BUILD.gn',
   'libvpx': 'third_party/libvpx/BUILD.gn',
   'libwebp': 'third_party/libwebp/BUILD.gn',
   'libxml': 'third_party/libxml/BUILD.gn',

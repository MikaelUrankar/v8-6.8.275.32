#!/bin/sh
BUILD_REV=b5df2518f091eea3d358f30757dec3e33db56156
BUILDTOOLS_REV=94288c26d2ffe3aec9848c147839afee597acefd
CLANG_REV=c893c7eec4706f8c7fc244ee254b1dadd8f8d158
COMMON_REV=211b3ed9d0481b4caddbee1322321b86a483ca1f
GOOGLETEST_REV=08d5b1f33af8c18785fb8ca02792b5fac81e248f
ICU_REV=f61e46dbee9d539a32551493e3bcc1dea92f83ec
V8_VERS=6.8.275.32

TAR=tar
FETCH_CMD=fetch
MKDIR=mkdir
DISTDIR=/usr/ports/distfiles

# Fetch
${FETCH_CMD} -o ${DISTDIR}/build-${BUILD_REV}.tar.gz \
        https://chromium.googlesource.com/chromium/src/build.git/+archive/${BUILD_REV}.tar.gz

${FETCH_CMD} -o ${DISTDIR}/buildtools-${BUILDTOOLS_REV}.tar.gz \
        https://chromium.googlesource.com/chromium/buildtools.git/+archive/${BUILDTOOLS_REV}.tar.gz

${FETCH_CMD} -o ${DISTDIR}/clang-${CLANG_REV}.tar.gz \
        https://chromium.googlesource.com/chromium/src/tools/clang.git/+archive/${CLANG_REV}.tar.gz

${FETCH_CMD} -o ${DISTDIR}/common-${COMMON_REV}.tar.gz \
        https://chromium.googlesource.com/chromium/src/base/trace_event/common.git/+archive/${COMMON_REV}.tar.gz

${FETCH_CMD} -o ${DISTDIR}/googletest-${GOOGLETEST_REV}.tar.gz \
        https://chromium.googlesource.com/external/github.com/google/googletest.git/+archive/${GOOGLETEST_REV}.tar.gz

${FETCH_CMD} -o ${DISTDIR}/icu-${ICU_REV}.tar.gz \
        https://chromium.googlesource.com/chromium/deps/icu.git/+archive/${ICU_REV}.tar.gz

${FETCH_CMD} -o ${DISTDIR}/v8-${V8_VERS}.tar.gz https://github.com/v8/v8/archive/refs/tags/${V8_VERS}.tar.gz

# Extract
WRKSRC=v8-${V8_VERS}
${TAR} -xf ${DISTDIR}/v8-${V8_VERS}.tar.gz
${MKDIR} -p \
        ${WRKSRC}/base/trace_event/common \
        ${WRKSRC}/build \
        ${WRKSRC}/buildtools \
        ${WRKSRC}/third_party/googletest/src \
        ${WRKSRC}/third_party/icu \
        ${WRKSRC}/third_party/googletest/src \
        ${WRKSRC}/tools/clang
${TAR} -xf ${DISTDIR}/build-${BUILD_REV}.tar.gz  -C ${WRKSRC}/build
${TAR} -xf ${DISTDIR}/buildtools-${BUILDTOOLS_REV}.tar.gz  -C ${WRKSRC}/buildtools
${TAR} -xf ${DISTDIR}/clang-${CLANG_REV}.tar.gz  -C ${WRKSRC}/tools/clang
${TAR} -xf ${DISTDIR}/common-${COMMON_REV}.tar.gz  -C ${WRKSRC}/base/trace_event/common
${TAR} -xf ${DISTDIR}/icu-${ICU_REV}.tar.gz -C ${WRKSRC}/third_party/icu
${TAR} -xf ${DISTDIR}/googletest-${GOOGLETEST_REV}.tar.gz -C ${WRKSRC}/third_party/googletest/src


# Patch
patches="patch-build_config_BUILD.gn
patch-build_config_BUILDCONFIG.gn
patch-build_config_compiler_BUILD.gn
patch-build_config_compiler_compiler.gni
patch-build_config_features.gni
patch-build_config_freetype_freetype.gni
patch-build_config_linux_pkg-config.py
patch-build_config_sysroot.gni
patch-build_gn_run_binary.py
patch-build_linux_libpci_BUILD.gn
patch-build_linux_unbundle_replace_gn_files.py
patch-build_toolchain_gcc_toolchain.gni
patch-build_toolchain_get_concurrent_links.py
patch-build_toolchain_linux_BUILD.gn
patch-BUILD.gn
patch-buildtools_third_party_libc++_BUILD.gn
patch-src_base_cpu.cc
patch-src_base_platform_platform-freebsd.cc
patch-src_base_platform_platform-posix.cc
patch-src_d8-posix.cc
patch-src_libsampler_sampler.cc
patches-build_config_linux_BUILD.gn"

for p in ${patches}
do
        patch -s -d v8-${V8_VERS} -i ../patches/${p}
done

# Build
cd v8-6.8.275.32
gn gen out/Release --args="v8_monolithic=true is_debug=false v8_static_library=true is_component_build=false is_clang=true use_sysroot=false treat_warnings_as_errors=false clang_use_chrome_plugins=false  use_lld=true use_custom_libcxx=false v8_use_external_startup_data=false is_component_build=false"
ninja -C out/Release

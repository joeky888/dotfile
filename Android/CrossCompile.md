TODO
=====
* aria2 busybox p7zip ffmpeg nano zsh curl openssh-server
* aria2: try https://github.com/lancethepants/aria2-arm-musl-static

Use clang
=====
```sh
cd android-ndk
# arch could be arm, arm64, x86, x86_64
./build/tools/make-standalone-toolchain.sh --arch=arm --package-dir=$PWD
tar -xvjf ./arm-linux-androideabi.tar.bz2
# Custom variable ANDROID_ABI
export ANDROID_ABI="arm-linux-androideabi"

# Example settings
export SYSROOT="$PWD/platforms/android-16/arch-arm"
export CC="$PWD/$ANDROID_ABI/bin/arm-linux-androideabi-clang"
export CXX="$PWD/$ANDROID_ABI/bin/arm-linux-androideabi-clang++"
export LDFLAGS="-static -L$SYSROOT/usr/lib -L$PWD/$ANDROID_ABI/sysroot/usr/lib -L$PWD/sysroot/usr/lib/$ANDROID_ABI"
export CPPFLAGS="-I$PWD/$ANDROID_ABI/sysroot/usr/include/ -I$PWD/sysroot/usr/include/$ANDROID_ABI -I$PWD/sysroot/usr/include"
```

Busybox (To be continued)
=====
```sh
#sudo apt-fast install libpam0g-dev libsepol1-dev libselinux1-dev libncurses5-dev libncursesw5-dev -y
cd android-ndk
git clone --depth 1 https://github.com/mirror/busybox busybox

export ANDROID_ABI="arm-linux-androideabi"
export CC="$PWD/$ANDROID_ABI/bin/$ANDROID_ABI-clang"
export CXX="$PWD/$ANDROID_ABI/bin/$ANDROID_ABI-clang++"
export ARCH="arm"
export CROSS_COMPILE="$PWD/$ANDROID_ABI/bin/$ANDROID_ABI-"
export CFLAGS="-I$PWD/busybox/include -I$PWD/$ANDROID_ABI/sysroot/usr/include -I$PWD/sysroot/usr/include/$ANDROID_ABI -I$PWD/sysroot/usr/include -static"
export CPPFLAGS="-I$PWD/busybox/include -I$PWD/$ANDROID_ABI/sysroot/usr/include -I$PWD/sysroot/usr/include/$ANDROID_ABI -I$PWD/sysroot/usr/include -static"
export LDFLAGS="-static -L$PWD/platforms/android-16/arch-arm/usr/lib -L$PWD/$ANDROID_ABI/sysroot/usr/lib -L$PWD/sysroot/usr/lib/$ANDROID_ABI"
export SYSROOT="$PWD/platforms/android-16/arch-arm"

cd ./busybox
git reset --hard && git clean -xdf && \
#make CONFIG_SYSROOT="$SYSROOT" CONFIG_EXTRA_LDLIBS="m c gcc" android_ndk_defconfig && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_EXTRA_LDLIBS="m c gcc" android2_defconfig && \
make clean && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_EXTRA_LDLIBS="m c gcc"

cd ./busybox
git reset --hard && git clean -xdf && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_CROSS_COMPILER_PREFIX="$CROSS_COMPILE" CONFIG_EXTRA_LDLIBS="m c gcc" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" android_ndk_defconfig && \
make clean && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_CROSS_COMPILER_PREFIX="$CROSS_COMPILE" CONFIG_EXTRA_LDLIBS="m c gcc" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS"
```

Toybox
=====
```sh
cd android-ndk
git clone --depth 1 https://github.com/landley/toybox toybox

export ANDROID_ABI="arm-linux-androideabi"
export PATH=$PATH:$PWD/$ANDROID_ABI/bin
export CC="clang"
export CXX="clang++"
export ARCH="arm"
export CROSS_COMPILE="$ANDROID_ABI-"
export CFLAGS="-I$PWD/$ANDROID_ABI/sysroot/usr/include -I$PWD/sysroot/usr/include/$ANDROID_ABI -I$PWD/sysroot/usr/include -static"
export CPPFLAGS="-I$PWD/$ANDROID_ABI/sysroot/usr/include -I$PWD/sysroot/usr/include/$ANDROID_ABI -I$PWD/sysroot/usr/include -static"
export LDFLAGS="-static -L$PWD/platforms/android-16/arch-arm/usr/lib -L$PWD/$ANDROID_ABI/sysroot/usr/lib -L$PWD/sysroot/usr/lib/$ANDROID_ABI"
export LDLIBS="-static -llog"
export SYSROOT="$PWD/platforms/android-16/arch-arm"

cd ./toybox
git reset --hard && git clean -xdf && \
rm -f ./toys/other/setfattr.c && \
rm -f ./toys/posix/getconf.c && \
rm -f ./toys/android/log.c && \
#sed -i '1 i\LOCAL_LDLIBS += -llog' ./Makefile && \
#sed -i '/confstr_vals/d' ./toys/posix/getconf.c && \
make CONFIG_SYSROOT="$SYSROOT" CROSS_COMPILE="$CROSS_COMPILE" CFLAGS="$CFLAGS" CC="$CC" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" defconfig && \
make CONFIG_SYSROOT="$SYSROOT" CROSS_COMPILE="$CROSS_COMPILE" CFLAGS="$CFLAGS" CC="$CC" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS"
```

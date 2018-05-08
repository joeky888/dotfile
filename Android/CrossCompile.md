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
export LDFLAGS="-L$PWD/$ANDROID_ABI/lib"
export CPPFLAGS="-I$PWD/$ANDROID_ABI/include"
```

Busybox (To be continued)
=====
```sh
cd android-ndk
git clone --depth 1 https://github.com/mirror/busybox busybox

export ANDROID_ABI="arm-linux-androideabi"
export CC="$PWD/$ANDROID_ABI/bin/arm-linux-androideabi-clang"
export CXX="$PWD/$ANDROID_ABI/bin/arm-linux-androideabi-clang++"
export ARCH="arm"
export CROSS_COMPILE="$PWD/$ANDROID_ABI/bin/$ANDROID_ABI-"
#export CFLAGS="-I$PWD/$ANDROID_ABI/include -I$PWD/sysroot/usr/include -I$PWD/$ANDROID_ABI/sysroot/usr/include/$ANDROID_ABI --static"
#export CPPFLAGS="-I$PWD/$ANDROID_ABI/include -I$PWD/sysroot/usr/include -I$PWD/$ANDROID_ABI/sysroot/usr/include/$ANDROID_ABI --static"
#export CFLAGS="-I$PWD/sysroot/usr/include/$ANDROID_ABI --static"
#export CPPFLAGS="-I$PWD/sysroot/usr/include/$ANDROID_ABI --static"
export CFLAGS="-I$PWD/busybox/include -I$PWD/$ANDROID_ABI/sysroot/usr/include -static"
export CPPFLAGS="-I$PWD/busybox/include -I$PWD/$ANDROID_ABI/sysroot/usr/include -static"
export LDFLAGS="-pthread -static"
export SYSROOT="$PWD/platforms/android-16/arch-arm"

cd ./busybox
make CONFIG_SYSROOT="$SYSROOT" CONFIG_EXTRA_LDLIBS="pthread m c gcc" android_ndk_defconfig && \
make clean && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_EXTRA_LDLIBS="pthread m c gcc"
```

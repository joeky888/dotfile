TODO
=====
* aria2 busybox p7zip ffmpeg nano zsh curl openssh
    * aria2: try https://github.com/lancethepants/aria2-arm-musl-static

Prepare gcc/clang cross compiler
=====
```sh
cd android-ndk
# arch could be arm, arm64, x86, x86_64
./build/tools/make_standalone_toolchain.py --arch=arm --package-dir=$PWD
./build/tools/make_standalone_toolchain.py --arch=x86 --package-dir=$PWD
tar xvjf ./arm-linux-androideabi.tar.bz2
tar xvjf ./i686-linux-android.tar.bz2
# Custom variable NDK_PREFIX
export NDK_PREFIX="arm-linux-androideabi"

# Example settings
export SYSROOT="$PWD/platforms/android-16/arch-arm"
export CC="$PWD/$NDK_PREFIX/bin/arm-linux-androideabi-clang"
export CXX="$PWD/$NDK_PREFIX/bin/arm-linux-androideabi-clang++"
export LDFLAGS="-static -L$SYSROOT/usr/lib -L$PWD/$NDK_PREFIX/sysroot/usr/lib -L$PWD/sysroot/usr/lib/$NDK_PREFIX"
export CPPFLAGS="-I$PWD/$NDK_PREFIX/sysroot/usr/include/ -I$PWD/sysroot/usr/include/$NDK_PREFIX -I$PWD/sysroot/usr/include"
```

Busybox (arm gcc)
=====
```sh
cd android-ndk
git clone --depth 1 https://github.com/mirror/busybox busybox

export NDK_PREFIX="arm-linux-androideabi"
export PATH=$PWD/$NDK_PREFIX/bin:$PATH
export CROSS_COMPILE="$NDK_PREFIX-"
export CROSS_COMPILER_PREFIX="$NDK_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export ARCH="arm"
export CFLAGS="-I$PWD/busybox/include -I$PWD/$NDK_PREFIX/sysroot/usr/include -I$PWD/sysroot/usr/include/$NDK_PREFIX -I$PWD/sysroot/usr/include -static"
export CPPFLAGS="-I$PWD/busybox/include -I$PWD/$NDK_PREFIX/sysroot/usr/include -I$PWD/sysroot/usr/include/$NDK_PREFIX -I$PWD/sysroot/usr/include -static"
export LDFLAGS="-static -L$PWD/$NDK_PREFIX/sysroot/usr/lib -L$PWD/sysroot/usr/lib/$NDK_PREFIX"
export LDLIBS="-static -lm -Wl,--allow-multiple-definition"
export SYSROOT="$PWD/platforms/android-16/arch-arm"

cd ./busybox
git reset --hard && git clean -xdf && \
#rm -f ./libbb/missing_syscalls.c
#rm -f ./miscutils/setfattr.c
#rm -f ./archival/libarchive/data_extract_to_command.c
#sed -e 's/.*FEATURE_PREFER_APPLETS.*/CONFIG_FEATURE_PREFER_APPLETS=y/' -i .config && \
#sed -e 's/.*FEATURE_SH_STANDALONE.*/CONFIG_FEATURE_SH_STANDALONE=y/' -i .config && \
# Try android2_defconfig or android_ndk_defconfig
make clean && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_FEATURE_TOUCH_NODEREF=n CONFIG_CROSS_COMPILER_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" CFLAGS="$CFLAGS" CC="$CC" CONFIG_EXTRA_LDLIBS="m c gcc" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" android_ndk_defconfig && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_FEATURE_TOUCH_NODEREF=n CONFIG_CROSS_COMPILER_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" CFLAGS="$CFLAGS" CC="$CC" CONFIG_EXTRA_LDLIBS="m c gcc" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS"
```

Toybox (arm clang)
=====
```sh
cd android-ndk
git clone --depth 1 https://github.com/landley/toybox toybox

export NDK_PREFIX="arm-linux-androideabi"
export PATH=$PWD/$NDK_PREFIX/bin:$PATH
export CROSS_COMPILE="$NDK_PREFIX-"
export CC="${CROSS_COMPILE}clang"
export CXX="${CROSS_COMPILE}clang++"
export ARCH="arm"
export CFLAGS="-I$PWD/$NDK_PREFIX/sysroot/usr/include -I$PWD/sysroot/usr/include/$NDK_PREFIX -I$PWD/sysroot/usr/include -static"
export CPPFLAGS="-I$PWD/$NDK_PREFIX/sysroot/usr/include -I$PWD/sysroot/usr/include/$NDK_PREFIX -I$PWD/sysroot/usr/include -static"
export LDFLAGS="-static -L$PWD/platforms/android-16/arch-arm/usr/lib -L$PWD/$NDK_PREFIX/sysroot/usr/lib -L$PWD/sysroot/usr/lib/$NDK_PREFIX"
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

Aria2 (Android arm) (To be continued)
=====
```sh
export BASE=`pwd`
export PATH=$PWD/$NDK_PREFIX/bin:$PATH
export NDK_PREFIX="arm-linux-androideabi"
export SRC=$BASE/src
export DOWNLOAD="aria2c"
export DEST=$BASE/opt
export CC="$NDK_PREFIX-clang"
export CXX="$NDK_PREFIX-clang++"
export LDFLAGS="-L$DEST/lib"
export CPPFLAGS="-I$DEST/include"
export CFLAGS="-march=armv7-a -mtune=cortex-a9"
export CXXFLAGS=$CFLAGS
export CONFIGURE="./configure --prefix=/opt --host=arm-linux"
mkdir -p $SRC

######## ####################################################################
# ZLIB # ####################################################################
######## ####################################################################

git clone --depth 1 https://github.com/madler/zlib zlib
cd zlib
LDFLAGS=$LDFLAGS
CPPFLAGS=$CPPFLAGS
CFLAGS=$CFLAGS
CXXFLAGS=$CXXFLAGS
CROSS_PREFIX="$NDK_PREFIX-"
./configure --prefix=/opt

make -j 2
make install DESTDIR=$BASE
cd -

########### #################################################################
# OPENSSL # #################################################################
########### #################################################################

git clone --depth 1 https://github.com/openssl/openssl openssl
cd openssl

./Configure linux-armv4 $CFLAGS \
--prefix=/opt shared zlib zlib-dynamic \
-D_GNU_SOURCE -D_BSD_SOURCE \
--with-zlib-lib=$DEST/lib \
--with-zlib-include=$DEST/include

make CC=$CC
make CC=$CC install INSTALLTOP=$DEST OPENSSLDIR=$DEST/ssl
cd -

########## ##################################################################
# SQLITE # ##################################################################
########## ##################################################################

git clone --depth 1 https://github.com/mackyle/sqlite sqlite
cd sqlite

CC=clang
./configure --prefix=/opt --host=arm-linux

make -j 2
make install DESTDIR=$BASE

########### #################################################################
# LIBXML2 # #################################################################
########### #################################################################

git clone --depth 1 https://github.com/GNOME/libxml2 libxml2
cd libxml2

#patch < $PATCHES/libxml2-pthread.patch

CC=$CC \
CXX=$CXX \
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
./configure --prefix=/opt --host=arm-linux \
--with-zlib=$DEST \
--without-python

make LIBS="-lz"
make install DESTDIR=$BASE

########## ##################################################################
# C-ARES # ##################################################################
########## ##################################################################

mkdir $SRC/c-ares && cd $SRC/c-ares
$WGET http://c-ares.haxx.se/download/c-ares-1.10.0.tar.gz
tar zxvf c-ares-1.10.0.tar.gz
cd c-ares-1.10.0

CC=$CC \
CXX=$CXX \
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
./configure --prefix=/opt --host=arm-linux

make
make install DESTDIR=$BASE

########### #################################################################
# LIBSSH2 # #################################################################
########### #################################################################

mkdir $SRC/libssh2 && cd $SRC/libssh2
$WGET http://www.libssh2.org/download/libssh2-1.5.0.tar.gz
tar zxvf libssh2-1.5.0.tar.gz
cd libssh2-1.5.0

CC=$CC \
CXX=$CXX \
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
./configure --prefix=/opt --host=arm-linux

make LIBS="-lz -lssl -lcrypto"
make install DESTDIR=$BASE

######### ###################################################################
# ARIA2 # ###################################################################
######### ###################################################################

mkdir $SRC/aria2 && cd $SRC/aria2
$WGET http://sourceforge.net/projects/aria2/files/stable/aria2-1.19.0/aria2-1.19.0.tar.gz
tar zxvf aria2-1.19.0.tar.gz
cd aria2-1.19.0

CC=$CC \
CXX=$CXX \
LDFLAGS=$LDFLAGS \
CPPFLAGS=$CPPFLAGS \
CFLAGS=$CFLAGS \
CXXFLAGS=$CXXFLAGS \
./configure --prefix=/opt --host=arm-linux \
--enable-libaria2 \
--enable-static \
--disable-shared \
--without-libuv \
--without-appletls \
--without-gnutls \
--without-libnettle \
--without-libgmp \
--without-libgcrypt \
--without-libexpat \
--with-xml-prefix=$DEST \
ZLIB_CFLAGS="-I$DEST/include" \
ZLIB_LIBS="-L$DEST/lib" \
OPENSSL_CFLAGS="-I$DEST/include" \
OPENSSL_LIBS="-L$DEST/lib" \
SQLITE3_CFLAGS="-I$DEST/include" \
SQLITE3_LIBS="-L$DEST/lib" \
LIBCARES_CFLAGS="-I$DEST/include" \
LIBCARES_LIBS="-L$DEST/lib" \
LIBSSH2_CFLAGS="-I$DEST/include" \
LIBSSH2_LIBS="-L$DEST/lib" \
ARIA2_STATIC=yes

make LIBS="-lz -lssl -lcrypto -lsqlite3 -lcares -lxml2 -lssh2"

make install DESTDIR=$BASE/aria2
```

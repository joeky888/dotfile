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
export PATH=$PWD/$ANDROID_ABI/bin:$PATH
export CROSS_COMPILE="$ANDROID_ABI-"
export CROSS_COMPILER_PREFIX="$ANDROID_ABI-"
export CC="clang"
export CXX="clang++"
export ARCH="arm"
export CFLAGS="-I$PWD/busybox/include -I$PWD/$ANDROID_ABI/sysroot/usr/include -I$PWD/sysroot/usr/include/$ANDROID_ABI -I$PWD/sysroot/usr/include -static"
export CPPFLAGS="-I$PWD/busybox/include -I$PWD/$ANDROID_ABI/sysroot/usr/include -I$PWD/sysroot/usr/include/$ANDROID_ABI -I$PWD/sysroot/usr/include -static"
export LDFLAGS="-static -L$PWD/$ANDROID_ABI/sysroot/usr/lib -L$PWD/sysroot/usr/lib/$ANDROID_ABI"
export LDLIBS="-static -llog"
export SYSROOT="$PWD/platforms/android-16/arch-arm"

cd ./busybox
git reset --hard && git clean -xdf && \
rm -f ./libbb/missing_syscalls.c
rm -f ./miscutils/setfattr.c
# Try android2_defconfig or android_ndk_defconfig
make CONFIG_SYSROOT="$SYSROOT" CONFIG_FEATURE_TOUCH_NODEREF=n CONFIG_CROSS_COMPILER_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" CFLAGS="$CFLAGS" CC="$CC" CONFIG_EXTRA_LDLIBS="m c gcc" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" android_ndk_defconfig && \
make clean && \
make CONFIG_SYSROOT="$SYSROOT" CONFIG_FEATURE_TOUCH_NODEREF=n CONFIG_CROSS_COMPILER_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" CFLAGS="$CFLAGS" CC="$CC" CONFIG_EXTRA_LDLIBS="m c gcc" EXTRA_LDFLAGS="$LDFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS"
```

Toybox
=====
```sh
cd android-ndk
git clone --depth 1 https://github.com/landley/toybox toybox

export ANDROID_ABI="arm-linux-androideabi"
export PATH=$PWD/$ANDROID_ABI/bin:$PATH
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

Aria2 (Android arm) (To be continued)
=====
```sh
export BASE=`pwd`
export PATH=$PWD/$ANDROID_ABI/bin:$PATH
export ANDROID_ABI="arm-linux-androideabi"
export SRC=$BASE/src
export DOWNLOAD="aria2c"
export DEST=$BASE/opt
export CC="$ANDROID_ABI-clang"
export CXX="$ANDROID_ABI-clang++"
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
CROSS_PREFIX="$ANDROID_ABI-"
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

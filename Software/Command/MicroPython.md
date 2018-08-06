Compile
=====
```sh
git submodule update --init
cd ports/unix
make axtls
make
./micropython
```

Cross compile
=====
```sh
sed -i "s/^SigLevel.*/SigLevel=Never/g" /etc/pacman.conf
#pacman -S git make gcc pkgconf autoconf automake sudo --noconfirm
#pacman -S aarch64-linux-gnu-gcc --noconfirm

apt install -y git make gcc pkgconf autoconf automake libtool-bin texinfo python

git clone --depth 1 https://github.com/jeremyhu/libffi $HOME/libffi
git clone --depth 1 https://github.com/micropython/micropython $HOME/micropython

# mpy-cross doesn't need to use cross compiler
cd $HOME/micropython/mpy-cross
make clean
make

##############################################
apt install -y gcc-aarch64-linux-gnu

export CC_PREFIX="aarch64-linux-gnu"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CFLAGS_EXTRA="-I$LIB_CACHE/include"
export LDFLAGS_EXTRA="-static -lffi -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
cd $HOME/libffi
make clean
./autogen.sh
./configure --prefix=$LIB_CACHE --host=$CC_PREFIX
make
make install

cd $HOME/micropython/ports/unix
make clean
make V=1 CROSS_COMPILE="$CROSS_COMPILE" axtls
make V=1 CROSS_COMPILE="$CROSS_COMPILE" LDFLAGS_EXTRA="$LDFLAGS_EXTRA"
cp micropython $HOME/$CC_PREFIX

##############################################
apt install -y gcc-arm-linux-gnueabi

export CC_PREFIX="arm-linux-gnueabi"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CFLAGS_EXTRA="-I$LIB_CACHE/include"
export LDFLAGS_EXTRA="-static -lffi -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
cd $HOME/libffi
make clean
./autogen.sh
./configure --prefix=$LIB_CACHE --host=$CC_PREFIX
make
make install

cd $HOME/micropython/ports/unix
make clean
make V=1 CROSS_COMPILE="$CROSS_COMPILE" axtls
make V=1 CROSS_COMPILE="$CROSS_COMPILE" LDFLAGS_EXTRA="$LDFLAGS_EXTRA"
cp micropython $HOME/$CC_PREFIX

##############################################
apt install -y gcc-mingw-w64-x86-64
#cp /usr/arm-linux-gnueabi/include/malloc.h /usr/arm-linux-gnueabi/include/alloca.h
export CC_PREFIX="x86_64-w64-mingw32"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CFLAGS_EXTRA="-I$LIB_CACHE/include"
export LDFLAGS_EXTRA="-static -lffi -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
cd $HOME/libffi
make clean
./autogen.sh
./configure --prefix=$LIB_CACHE --host=$CC_PREFIX
make
make install

cd $HOME/micropython/ports/windows
make clean
make V=1 CROSS_COMPILE="$CROSS_COMPILE" axtls
make V=1 CROSS_COMPILE="$CROSS_COMPILE" LDFLAGS_EXTRA="$LDFLAGS_EXTRA"
cp micropython.exe $HOME/$CC_PREFIX
##############################################
export DL_MIRROR="https://dl.google.com"
apt install -y google-android-ndk-installer
cd $HOME
# arch could be arm, arm64, x86, x86_64
echo "Downloading arm64 toolchain..."
/usr/lib/android-ndk/build/tools/make_standalone_toolchain.py --arch=arm64 --package-dir=$PWD
echo "Downloading x86_64 toolchain..."
/usr/lib/android-ndk/build/tools/make_standalone_toolchain.py --arch=x86_64 --package-dir=$PWD
tar jxvf ./aarch64-linux-android.tar.bz2
tar jxvf ./x86_64-linux-android.tar.bz2

export CC_PREFIX="aarch64-linux-android"
export PATH=$PATH:$HOME/$CC_PREFIX/bin
export LIB_CACHE="$HOME/$CC_PREFIX"
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export SYSROOT="$HOME/$CC_PREFIX/sysroot/"
export CFLAGS_EXTRA="-I$LIB_CACHE/sysroot/usr/include -I$LIB_CACHE/include --sysroot=$SYSROOT"
export LDFLAGS_EXTRA="-lffi -L$LIB_CACHE/sysroot/usr/lib -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib -Wl,--no-as-needed"
cd $HOME/libffi
make clean
./autogen.sh
./configure --prefix=$LIB_CACHE --host=$CC_PREFIX
make
make install
cp -R $HOME/micropython/lib/libffi/build_dir/out/lib64/* $HOME/micropython/lib/libffi/build_dir/out/lib
cp $HOME/$CC_PREFIX/sysroot/usr/lib/libdl.so $HOME/micropython/lib/libffi/build_dir/out/lib

cd $HOME/micropython/ports/unix
sed  -i '1i #define MP_S_IFDIR (0x4000)' modos.c
sed  -i '1i #define MP_S_IFREG (0x8000)' modos.c
sed  -i '/.*-ldl.*/d' Makefile
make clean
#make V=1 CROSS_COMPILE="$CROSS_COMPILE" libffi
make V=1 CROSS_COMPILE="$CROSS_COMPILE" axtls
make V=1 CROSS_COMPILE="$CROSS_COMPILE" LDFLAGS_EXTRA="$LDFLAGS_EXTRA" MICROPY_PY_THREAD=0
cp micropython $HOME/$CC_PREFIX
```

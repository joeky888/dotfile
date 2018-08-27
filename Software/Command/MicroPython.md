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
#sed -i "s/^SigLevel.*/SigLevel=Never/g" /etc/pacman.conf
#pacman -S git make gcc pkgconf autoconf automake sudo --noconfirm
#pacman -S aarch64-linux-gnu-gcc --noconfirm

apt install -y git make gcc pkgconf autoconf automake libtool-bin texinfo python

git clone --depth 1 https://github.com/jeremyhu/libffi $HOME/libffi
git clone --depth 1 https://github.com/micropython/micropython $HOME/micropython

# mpy-cross doesn't need to use cross compiler
cd $HOME/micropython/mpy-cross
make clean
make

################# arm64 Linux begin #####################
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

################# arm64 Linux end   #####################
################# arm32 Linux begin #####################
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

################# arm32 Linux end   #####################
################# mips Linux begin #####################
apt install -y gcc-mips-linux-gnu

export CC_PREFIX="mips-linux-gnu"
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

################# mips Linux end   #####################
################# win64 begin #####################
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

################# win64 end #####################

#export DL_MIRROR="https://dl.google.com"
#apt install -y google-android-ndk-installer
cd $HOME

wget https://dl.google.com/android/repository/android-ndk-r17b-linux-x86_64.zip
unzip android-ndk-r17b-linux-x86_64.zip
mv android-ndk-r17b android-ndk && cd android-ndk

# arch could be arm, arm64, x86, x86_64
echo "Downloading arm64 toolchain..."
./build/tools/make_standalone_toolchain.py --arch=arm64 --api 21 --package-dir=$PWD
tar jxvf ./aarch64-linux-android.tar.bz2
echo "Downloading x86_64 toolchain..."
./build/tools/make_standalone_toolchain.py --arch=x86_64 --api 21 --package-dir=$PWD
tar jxvf ./x86_64-linux-android.tar.bz2

export CC_PREFIX="aarch64-linux-android"
export PATH=$PATH:$HOME/android-ndk/$CC_PREFIX/bin
export LIB_CACHE="$HOME/$CC_PREFIX"
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
#export CXX="${CROSS_COMPILE}gcc++"
#export SYSROOT="$HOME/android-ndk/$CC_PREFIX/sysroot/"
export CFLAGS_EXTRA="-I$LIB_CACHE/include -O3"
export LDFLAGS_EXTRA="-L$LIB_CACHE/lib64 -L$LIB_CACHE/lib -lffi -static -Wl,--allow-multiple-definition"
cd $HOME/libffi
make clean
./autogen.sh
./configure --prefix=$LIB_CACHE --host=$CC_PREFIX
make CC=$CC
make install

cd $HOME/micropython/ports/unix
make clean
sed  -i '1i #define MP_S_IFDIR (0x4000)' modos.c
sed  -i '1i #define MP_S_IFREG (0x8000)' modos.c
#sed  -i '/.*-ldl.*/d' Makefile
make V=1 CROSS_COMPILE="$CROSS_COMPILE" CC=$CC axtls
make V=1 CROSS_COMPILE="$CROSS_COMPILE" CC=$CC LDFLAGS_EXTRA="$LDFLAGS_EXTRA" MICROPY_PY_THREAD=0
cp micropython $HOME/$CC_PREFIX
cp micropython /data/data/com.termux/files/usr/bin
```

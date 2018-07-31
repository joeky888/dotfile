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
pacman -S git make gcc pkgconf autoconf automake --noconfirm
pacman -S aarch64-linux-gnu-gcc --noconfirm

git clone --depth 1 https://github.com/libffi/libffi $HOME/libffi
git clone --depth 1 https://github.com/micropython/micropython $HOME/micropython

# mpy-cross doesn't need to use cross compiler
cd $HOME/micropython/mpy-cross
make clean
make

##############################################

export CC_PREFIX="aarch64-linux-gnu"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CFLAGS_EXTRA=""
export LDFLAGS_EXTRA="-static -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
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
pacman -S bison linux-api-headers --noconfirm
git clone --depth 1 git://sourceware.org/git/glibc.git $HOME/glibc
#git clone --depth 1 git://sourceware.org/git/glibc-ports.git $HOME/glibc/ports
mkdir -p $HOME/glibc/glibcbuild && cd $HOME/glibc/glibcbuild
export CC_PREFIX="arm-none-eabi"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CFLAGS_EXTRA="-I/usr/include -I/usr/include/linux"
export LDFLAGS_EXTRA="-static -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
../configure CC="${CROSS_COMPILE}gcc" --prefix=$LIB_CACHE --host=arm-linux --build=$CC_PREFIX --with-headers=/usr/include
#    --enable-add-on=nptl \
#    libc_cv_forced_unwind=yes \
#    libc_cv_c_cleanup=yes \
#    libc_cv_mips_tls=yes \
#    libc_cv_gnu99_inline=yes
make
make install

export CC_PREFIX="arm-none-eabi"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CFLAGS_EXTRA="-I/usr/include -I/usr/include/linux"
export LDFLAGS_EXTRA="-static -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
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
```

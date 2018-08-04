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
pacman -S git make gcc pkgconf autoconf automake sudo --noconfirm
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

pacman -S bison flex man-pages arm-none-eabi-gcc arm-none-eabi-newlib linux-api-headers --noconfirm
pacman -S mingw-w64-gcc --noconfirm
git clone --depth 1 git://sourceware.org/git/glibc.git $HOME/glibc
#git clone --depth 1 git://sourceware.org/git/glibc-ports.git $HOME/glibc/ports
cd $HOME/glibc && git reset --hard && git clean -xdf
mkdir -p $HOME/glibc/glibcbuild && cd $HOME/glibc/glibcbuild
echo 'libc_cv_forced_unwind=yes' > config.cache
echo 'libc_cv_c_cleanup=yes' >> config.cache
echo 'libc_cv_mips_tls=yes' >> config.cache
echo 'libc_cv_gnu99_inline=yes' >> config.cache
sed -i '1s/^/#define __builtin_thread_pointer()  ((void *) 0)/' $HOME/glibc/sysdeps/unix/sysv/linux/arm/tls.h
export CC_PREFIX="x86_64-w64-mingw32"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export LD="${CROSS_COMPILE}ld"
export AS="${CROSS_COMPILE}as"
#export CFLAGS_EXTRA=""
#export LDFLAGS_EXTRA="-static -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
export HOST="mingw64"
export BUILD="x86_64-pc-linux-gnu"
export TARGET="mingw64"
$HOME/glibc/configure CC=$CC CXX=$CXX LD=$LD AS=$AS --prefix=$LIB_CACHE --build=$BUILD --target=$TARGET --host=$HOST --with-headers=/usr/include --config-cache

#useradd -ms /bin/bash docker
#echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#gpg --recv-keys 13FCEF89DD9E3C4F
#runuser -l docker -c "gpg --recv-keys 13FCEF89DD9E3C4F"
#yes | runuser -l docker -c "yaourt --noconfirm -S mingw-w64-crt mingw-w64-gcc-bin"
#echo "NOCONFIRM=1
#BUILD_NOCONFIRM=1
#EDITFILES=0
#" > ~/.yaourtrc
export CC_PREFIX="x86_64-w64-mingw32"
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
pacman -S bison flex man-pages arm-none-eabi-gcc arm-none-eabi-newlib linux-api-headers --noconfirm
git clone --depth 1 git://sourceware.org/git/glibc.git $HOME/glibc
#git clone --depth 1 git://sourceware.org/git/glibc-ports.git $HOME/glibc/ports
cd $HOME/glibc && git reset --hard && git clean -xdf
mkdir -p $HOME/glibc/glibcbuild && cd $HOME/glibc/glibcbuild
echo 'libc_cv_forced_unwind=yes' > config.cache
echo 'libc_cv_c_cleanup=yes' >> config.cache
echo 'libc_cv_mips_tls=yes' >> config.cache
echo 'libc_cv_gnu99_inline=yes' >> config.cache
sed -i '1s/^/#define __builtin_thread_pointer()  ((void *) 0)/' $HOME/glibc/sysdeps/unix/sysv/linux/arm/tls.h
export CC_PREFIX="arm-none-eabi"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export LD="${CROSS_COMPILE}ld"
export AS="${CROSS_COMPILE}as"
#export CFLAGS_EXTRA=""
#export LDFLAGS_EXTRA="-static -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
export ARCH="arm-linux"
$HOME/glibc/configure CC=$CC CXX=$CXX LD=$LD AS=$AS --prefix=$LIB_CACHE --target=$ARCH --host=$ARCH --with-headers=/usr/include --config-cache
#    --enable-add-on=nptl \
#    libc_cv_forced_unwind=yes \
#    libc_cv_c_cleanup=yes \
#    libc_cv_mips_tls=yes \
#    libc_cv_gnu99_inline=yes
#make -k install-headers cross_compiling=yes install_root=$LIB_CACHE
mkdir -p $LIB_CACHE
make -k install-headers cross_compiling=yes install_root=$LIB_CACHE install

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

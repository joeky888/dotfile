Compile
=====
```sh
git submodule update --init
cd ports/unix
make axtls
make
./micropython
```

Cross compile (TODO)
=====
```sh
pacman -S git make gcc pkgconf autoconf automake --noconfirm
pacman -S aarch64-linux-gnu-gcc --noconfirm
export ARM_PREFIX="aarch64-linux-gnu"
export LIB_CACHE=$HOME/$ARM_PREFIX
export CROSS_COMPILE="$ARM_PREFIX-"
export CROSS_COMPILER_PREFIX="$ARM_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export ARCH="arm"

mkdir -p $LIB_CACHE
mkdir -p $LIB_CACHE/bin
git clone --depth 1 https://github.com/libffi/libffi $HOME/libffi
cd libffi
./autogen.sh
./configure --prefix=$LIB_CACHE --host=$ARM_PREFIX
make
make install

export ARM_PREFIX="aarch64-linux-gnu"
export LIB_CACHE=$HOME/$ARM_PREFIX
export CROSS_COMPILE="$ARM_PREFIX-"
export CROSS_COMPILER_PREFIX="$ARM_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export ARCH="arm"
git clone --depth 1 git://git.savannah.gnu.org/readline.git $HOME/readline
cd readline
./configure --prefix=$LIB_CACHE --host=$ARM_PREFIX
make
make install

git clone --depth 1 https://github.com/pfalcon/axtls $HOME/axtls
cd axtls
#cp config/linuxconfig .config
#sed -i 's|^PREFIX.*|PREFIX="\${HOME}/\${ARM_PREFIX}"|' .config
export ARM_PREFIX="aarch64-linux-gnu"
export CROSS_COMPILE="$ARM_PREFIX-"
export CROSS_COMPILER_PREFIX="$ARM_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export STRIP="${CROSS_COMPILE}strip"
export HOSTCC="gcc"
export CFLAGS="-fPIC -I$HOME/axtls-code/ssl -I$HOME/axtls-code/crypto -I$HOME/axtls-code/config"
export LDFLAGS="-L$LIB_CACHE/lib -L$LIB_CACHE/lib64 -L/usr/$ARM_PREFIX/lib -L/usr/$ARM_PREFIX/lib64 -L/usr/$ARM_PREFIX/usr/lib"
export LDLIBS="-Wl,--allow-multiple-definition"
export ARCH="arm"
make V=1 CC="$CC" HOSTCC="$CC" STRIP="$STRIP" HOST="$ARM_PREFIX" ARCH="$ARCH" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" CROSS_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" CROSS_COMPILER_PREFIX="$CROSS_COMPILER_PREFIX" PREFIX="$HOME/$ARM_PREFIX" linuxconf
make PREFIX="$HOME/$ARM_PREFIX" install


git clone --depth 1 https://github.com/micropython/micropython $HOME/micropython
git submodule update --init
git clone --depth 1 https://github.com/micropython/oofatfs $HOME/oofatfs
rm -rf ~/micropython/lib/oofatfs && cp -r ~/oofatfs/src/ ~/micropython/lib/oofatfs

cd ports/unix

export ARM_PREFIX="aarch64-linux-gnu"
export CROSS_COMPILE="$ARM_PREFIX-"
export CROSS_COMPILER_PREFIX="$ARM_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export STRIP="${CROSS_COMPILE}strip"
export HOSTCC="gcc"
export CFLAGS="-Wtraditional -fPIC -I$LIB_CACHE/include -I/usr/$ARM_PREFIX/include -I/usr/$ARM_PREFIX/usr/include -I$HOME/micropython -I$HOME/micropython/ports/unix -I$HOME/micropython/lib/axtls/ssl -I$HOME/micropython/lib/axtls/crypto -I$HOME/micropython/lib/axtls/config -I$HOME/micropython/lib/berkeley-db-1.xx/PORT/include -I$HOME/micropython/ports/unix/build"
export LDFLAGS="-L$LIB_CACHE/lib -L$LIB_CACHE/lib64 -L/usr/$ARM_PREFIX/lib -L/usr/$ARM_PREFIX/lib64 -L/usr/$ARM_PREFIX/usr/lib"
export LDLIBS="-Wl,--allow-multiple-definition"
export ARCH="arm"


# make V=1 CC="$CC" HOSTCC="$CC" HOST="$ARM_PREFIX" ARCH="$ARCH" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" CROSS_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" axtls
make V=1 CC="$CC" HOSTCC="$HOSTCC" STRIP="$STRIP" HOST="$ARM_PREFIX" ARCH="$ARCH" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" CROSS_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" CROSS_COMPILER_PREFIX="$CROSS_COMPILER_PREFIX" PREFIX="$HOME/$ARM_PREFIX" axtls
#make CROSS_COMPILE=$ARM_PREFIX V=1 axtls
make
./micropython
```

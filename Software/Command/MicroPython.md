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
sudo pacman -S aarch64-linux-gnu-gcc
export LIB_CACHE=$HOME/opt
mkdir -p $LIB_CACHE
git clone --depth 1 https://github.com/libffi/libffi
cd libffi
./autogen.sh
./configure --prefix=$LIB_CACHE --host=aarch64-linux-gnu
export ARM_PREFIX="aarch64-linux-gnu"
export CROSS_COMPILE="$ARM_PREFIX-"
export CROSS_COMPILER_PREFIX="$ARM_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export ARCH="arm"
make
make install

git clone --depth 1 https://github.com/micropython/micropython
git submodule update --init
cd ports/unix

export ARM_PREFIX="aarch64-linux-gnu"
export CROSS_COMPILE="$ARM_PREFIX-"
export CROSS_COMPILER_PREFIX="$ARM_PREFIX-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export CFLAGS="-I$LIB_CACHE/include  -static"
export LDFLAGS="-static -L$LIB_CACHE/lib64"
export LDLIBS="-static -lm -Wl,--allow-multiple-definition"
export ARCH="arm"


make V=1 CC="$CC" HOSTCC="$CC" HOST="$ARM_PREFIX" ARCH="$ARCH" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" CROSS_PREFIX="$CROSS_COMPILE" CROSS_COMPILE="$CROSS_COMPILE" axtls
#make CROSS_COMPILE=$ARM_PREFIX V=1 axtls
make
./micropython
```

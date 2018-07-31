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

export ARM_PREFIX="aarch64-linux-gnu"
export LIB_CACHE=$HOME/$ARM_PREFIX
export CROSS_COMPILE="$ARM_PREFIX-"
export CROSS_COMPILER_PREFIX="$ARM_PREFIX-"
export CFLAGS_EXTRA=""
export LDFLAGS_EXTRA="-static -L$LIB_CACHE/lib64 -L$LIB_CACHE/lib"
cd $HOME/libffi
make clean
./autogen.sh
./configure --prefix=$LIB_CACHE --host=$ARM_PREFIX
make
make install

cd $HOME/micropython/ports/unix
make clean
make V=1 CROSS_COMPILE="$CROSS_COMPILE" axtls
make V=1 CROSS_COMPILE="$CROSS_COMPILE" LDFLAGS_EXTRA="$LDFLAGS_EXTRA"
./micropython
```

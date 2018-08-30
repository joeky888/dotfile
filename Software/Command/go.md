Get all platforms
=====
```sh
go tool dist list
go tool dist list -json
```

Cross compile webrtc and openssl with CGO
=====
```sh
apt install -y git make gcc golang pkgconf autoconf automake libtool-bin texinfo python wget

git clone --depth 1 https://github.com/openssl/openssl /root/openssl
git clone --depth 1 https://github.com/pions/webrtc /root/webrtc

apt install -y gcc-aarch64-linux-gnu

export CC_PREFIX="aarch64-linux-gnu"
export LIB_CACHE=$HOME/$CC_PREFIX
export CROSS_COMPILE="$CC_PREFIX-"
export CROSS_COMPILER_PREFIX="$CC_PREFIX-"
export CGO_CFLAGS="-I$LIB_CACHE/include"
export CGO_LDFLAGS="-L$LIB_CACHE/lib64 -L$LIB_CACHE/lib -L/usr/$CC_PREFIX/lib -lssl -lcrypto -ldl"

cd /root/openssl && git reset --hard  && git clean -xdf

./Configure linux-aarch64 --prefix=$LIB_CACHE --openssldir=$LIB_CACHE
make clean
make CC=${CROSS_COMPILE}gcc RANLIB=${CROSS_COMPILE}ranlib LD=${CROSS_COMPILE}ld MAKEDEPPROG=${CROSS_COMPILE}gcc
make CC=${CROSS_COMPILE}gcc RANLIB=${CROSS_COMPILE}ranlib LD=${CROSS_COMPILE}ld MAKEDEPPROG=${CROSS_COMPILE}gcc INSTALLTOP=$LIB_CACHE install_sw

##################################################

apt install -y libssl-dev
go get -insecure -v github.com/pions/webrtc

cd /root/webrtc/examples/data-channels
GOOS=linux GOARCH=arm64 CGO_ENABLED=1 CC=${CROSS_COMPILE}gcc CGO_CFLAGS=$CGO_CFLAGS CGO_LDFLAGS=$CGO_LDFLAGS go env
GOOS=linux GOARCH=arm64 CGO_ENABLED=1 CC=${CROSS_COMPILE}gcc CGO_CFLAGS=$CGO_CFLAGS CGO_LDFLAGS=$CGO_LDFLAGS go build -ldflags "-w -extldflags '-static $CGO_LDFLAGS'"

docker cp deb:/root/webrtc/examples/data-channels/data-channels .

adb push data-channels /
```

Zig cc
=====
* $ zig targets | jq .libc # Show all avaiable toolchains

Compile oniguruma with zig cc
=====
```sh
CC="zig cc -target aarch64-linux-musl -static" ./configure --host=aarch64-linux-musl --prefix=$PWD/output
make
make install
ls ./output
```


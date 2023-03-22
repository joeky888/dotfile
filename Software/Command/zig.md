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

Compile oniguruma to wasm (zig)
=====
```sh
autoreconf -vfi && emconfigure ./configure && make CC="zig cc --target=wasm32-wasi -Wl,--export-all -Wl,--no-entry"
```

Compile oniguruma to wasm (emmake)
=====
```sh
autoreconf -vfi && emconfigure ./configure && make clean && emmake make
```


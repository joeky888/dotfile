Setup
=====
* $ app-fast -S rustup
* $ rustup update beta # Channels can be "stable" "beta" "nightly"

Setup for windows
=====
```sh
scoop install rustup
rustup toolchain list
rustup update stable
rustup toolchain uninstall stable-x86_64-pc-windows-gnu
rustup toolchain uninstall stable-x86_64-pc-windows-msvc
rustup default stable-x86_64-pc-windows-gnu

rustup target list
rustup target remove xxx
```
Cross compile (without cross)
=====
* Still need to install the gcc cross-compiler though to get it work
```sh
rustup target add x86_64-unknown-linux-musl --toolchain stable
cargo build --target x86_64-unknown-linux-musl

rustup target add x86_64-pc-windows-gnu --toolchain stable
cargo build --target x86_64-pc-windows-gnu
```

Cross compile (with cross)
=====
* $ app-fast -S cross
* $ cd /path/to/project
```sh
# Build x64 static binary
cross build --target x86_64-unknown-linux-musl --release
ls target/x86_64-unknown-linux-musl/release

# Build arm64 static binary
cross build --target aarch64-unknown-linux-musl --release
ls target/aarch64-unknown-linux-musl/release
```

VScode integration
=====
* Install rust-lang.rust and vadimcn.vscode-lldb
* Set `"rust-client.engine": "rust-analyzer"`

VScode new project
=====
* New
    * $ cargo new helloworld
* Run
    * $ cargo run --release
* Build
    * $ cargo build --release

Merge multiple line into one (To make sure tree-shaking works)
=====
```sh
cargo fmt -- --config imports_granularity=Item # Split them first
cargo fmt -- --config imports_granularity=Crate # Then merge them
```

VScode debug
=====
* On Linux and macOS use vadimcn.vscode-lldb
* On Windows use ms-vscode.cpptools
```js
{
    "name": "(Unix) Debug 'rust-playground' with vadimcn.vscode-lldb",
    "type": "lldb",
    "request": "launch",
    "cargo": {
        "args": [
            "build",
            "--bin=rust-playground",
            "--package=rust-playground"
        ],
        "filter": {
            "name": "rust-playground",
            "kind": "bin"
        }
    },
    "env": {
        "DATABASE_HOST": "mysql",
        "RUST_BACKTRACE": "1",
    },
    "args": [],
    "cwd": "${workspaceFolder}",
    "internalConsoleOptions": "neverOpen", // This will set the default debug panel to "Terminal" instead of "Debug Console"
},
{
    "name": "(Windows) Debug 'rust-playground' with ms-vscode.cpptools",
    "type": "cppvsdbg",
    "request": "launch",
    "program": "${workspaceFolder}/target/debug/rust-playground.exe",
    "stopAtEntry": false,
    "cwd": "${workspaceFolder}",
    "sourceFileMap": {
        "/rustc/5e1a799842ba6ed4a57e91f7ab9435947482f7d8": "${env:USERPROFILE}/.rustup/toolchains/stable-x86_64-pc-windows-msvc/lib/rustlib/src/rust"
    },
    "symbolSearchPath": "https://msdl.microsoft.com/download/symbols",
    "environment": [],
    "args": []
}
```

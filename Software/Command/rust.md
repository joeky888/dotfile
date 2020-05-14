Setup
=====
* Install rust using curl
* $ rustup update stable

VScode integration (install rust-analyzer from source)
=====
* Make sure
    * Node and npm is installed
    * `code` command is available in system path
    * rls vscode extension is not installed
* $ git clone --depth 1 https://github.com/rust-analyzer/rust-analyzer && cd rust-analyzer
* $ cargo xtask install

VScode release
=====
* Run
    * $ cargo run --release
* Build
    * $ cargo build --release

VScode debug
=====
```js
{
    "type": "lldb",
    "request": "launch",
    "name": "Debug executable 'rust-playground'",
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
    },
    "args": [],
    "cwd": "${workspaceFolder}"
}
```

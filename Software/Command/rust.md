Setup
=====
* Install rust using curl
* $ rustup update stable

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

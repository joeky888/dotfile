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
    },
    "args": [],
    "cwd": "${workspaceFolder}"
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

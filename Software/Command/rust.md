Setup
=====
* Install rust using curl
* $ rustup update stable

Upgrade
=====
* $ rustup update

VScode integration (install rust-analyzer from source)
=====
* Make sure
    * Node and npm is installed
    * `code` command is available in system path
    * rls vscode extension is not installed
* $ git clone --depth 1 https://github.com/rust-analyzer/rust-analyzer && cd rust-analyzer
* $ cargo xtask install


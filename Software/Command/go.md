Get all platforms
=====
```sh
go tool dist list
go tool dist list -json
vim go/src/cmd/dist/build.go # Search "okgoarch" and "okgoos"
```

Go mod (Golang >= 1.11)
=====
* $ export GO111MODULE=on
* $ go mod init
* $ go mod download
* $ go mod tidy
* For Golang >- 1.13
* $ go mod edit -go=1.13

Vscode upgrade all go tools
=====
* Hit `Ctrl+P` enter `> go Install/Update tools`
* Select all and update

Build go project in dockerfile (Assume the dockerfile is on the root of the project)
=====
```dockerfile
ENV GOPATH /go
ENV CGO_ENABLED 0
RUN go get -u -v github.com/golang/dep/cmd/dep
ENV GO111MODULE on

RUN mkdir -p $GOPATH/src/myproject
WORKDIR $GOPATH/src/myproject
ADD . .
RUN go get -d ./...
RUN go build -o /bin/myexe
```

Debug in vscode
=====
* $ go get -u -v github.com/go-delve/delve/cmd/dlv
* vscode -> Debug -> Open Configurations
```js
{
    "name": "Launch debug",
    "type": "go",
    "request": "launch",
    "mode": "debug",
    "remotePath": "",
    "port": 2345,
    "host": "127.0.0.1",
    "program": "${workspaceFolder}",
    "env": {
        "MY_GOPATH":"/GOGO",
        "GODEBUG": "netdns=go+2"
    },
    "args": ["-f", "/etc/config/run-libgo.yaml", "run"],
    "buildFlags": "-tags 'TAG1 TAG2 TAG3'", // go build -tag TAG1
    "showLog": false
}
```
* Now break points should work

Debug in go test
=====
* $ go get -u -v github.com/go-delve/delve/cmd/dlv
* Don't start dlv server
* vscode -> Debug -> Open Configurations
```js
{
    "name": "Launch testing",
    "type": "go",
    "request": "launch",
    "mode": "test",
    "remotePath": "",
    "port": 2345,
    "host": "127.0.0.1",
    "program": "${workspaceFolder}/integration",
    "env": {
        "MY_GOPATH":"/GOGO",
        "GODEBUG": "netdns=go+2"
    },
    "args": ["--godog.tags=B2bHistoryOrder"],
    "buildFlags": "-tags 'TAG1 TAG2 TAG3'", // go build -tag TAG1
    "showLog": false
}
```

Debug in vscode, but shows logs in terminal (Remote debug mode)
=====
* $ go get -u -v github.com/go-delve/delve/cmd/dlv
* This is remote debugging mode so setting args and env in vscode json doesn't work
* $ cd /path/to/project && MYGOPATH=/GOGO REDIS=host.docker.internal dlv debug --headless --listen=:2345 --log --api-version=2 --build-flags "-tags 'TAG1 TAG2 TAG3'" -- -f /etc/config/run-libgo.yaml other:args
* Break points in vscode should work
* vscode -> Debug -> Open Configurations
```js
{
    "name": "Launch remote",
    "type": "go",
    "request": "attach",
    "mode": "remote",
    "remotePath": "/absolute/path/to/the/remote/project",
    "port": 2345,
    "host": "127.0.0.1",
    //"program": "${workspaceFolder}", // This won't work
    //"buildFlags": "-tags 'TAG1 TAG2 TAG3'", // This won't work
    "showLog": false
}
```

Debug with lldb for mac, gdb for Linux and Windows
=====
* Install ms-vscode.cpptools vscode extension
* Make sure lldb command is available
* ./vscode/launch.json
```js
{
    "type": "cppdbg",
    "request": "launch",
    "name": "cpp debugger",
    "preLaunchTask": "go build for gdb/lldb",
    "cwd": "${workspaceRoot}",
    "program": "${workspaceRoot}/myfile.exe",
    "linux": {
        "MIMode": "gdb",
        "miDebuggerPath": "/usr/bin/gdb"
     },
     "osx": {
        "MIMode": "lldb"
     },
     "windows": {
        "MIMode": "gdb",
        "miDebuggerPath": "C:\\MinGw\\bin\\gdb.exe"
     }
}
```
* ./vscode/tasks.json
```js
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "go build for gdb/lldb",
            "type": "shell",
            "command": "go build -ldflags=-compressdwarf=false -o myfile.exe"
        }
    ]
}
```

Test with lldb for mac, gdb for Linux and Windows
=====
* Install ms-vscode.cpptools vscode extension
* Make sure lldb command is available
* ./vscode/launch.json
```js
{
    "type": "cppdbg",
    "request": "launch",
    "name": "cpp debugger",
    "preLaunchTask": "go test for gdb/lldb",
    "cwd": "${workspaceRoot}/integration",
    "program": "${workspaceRoot}/integration/integration.test",
    "linux": {
        "MIMode": "gdb",
        "miDebuggerPath": "/usr/bin/gdb"
     },
     "osx": {
        "MIMode": "lldb"
     },
     "windows": {
        "MIMode": "gdb",
        "miDebuggerPath": "C:\\MinGw\\bin\\gdb.exe"
     }
}
```
* ./vscode/tasks.json
```js
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "go test for gdb/lldb",
            "type": "shell",
            "options": {
                "cwd": "${workspaceFolder}/integration"
            },
            "command": "go test -c -ldflags=-compressdwarf=false -tags integration"
        }
    ]
}
```


Static compile
=====
```sh
CGO_ENABLED=0 go build
# Or
CGO_ENABLED=1 go build -ldflags "-w -s -linkmode external -extldflags '-s -static'"
# Or
CGO_ENABLED=1 go build -ldflags "-w -s -extldflags '-s -static'"
```

CGO on Windows powershell
=====
```sh
$env:PATH="C:\cygwin64\bin;$env:PATH"
$env:CGO_ENABLED="1"
$env:CC="x86_64-w64-mingw32-gcc.exe"
$env:CXX="x86_64-w64-mingw32-g++.exe"
$env:PKG_CONFIG="x86_64-w64-mingw32-pkg-config.exe"

go env
# gcc -s Make the size 10x smaller
go build -ldflags "-w -s -extldflags '-s -static --sysroot=C:\cygwin64\usr\x86_64-w64-mingw32\sys-root'"
upx --lzma file.exe
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

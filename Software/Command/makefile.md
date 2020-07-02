Use make on windows
=====
* Create a file make.bat
```dosbatch
@ECHO off
if [%1]==[] goto :default
if /I %1 == install goto :install
if /I %1 == clean goto :clean

goto :eof ::can be ommited to run the `default` function similarly to makefiles

:default
echo DEFAULT
goto :eof

:install
echo INSTALL
goto :eof

:clean
echo CLEAN
goto :eof
```

Equal sign
=====
*  = Set a variable
* := Overrite a variable
* ?= Set a variable only if it is null
* += Append a string to the variable

pkg-config
=====
* Get all includes and libs path
```sh
pkg-config --list-all | grep gstreamer
pkg-config --cflags --libs gstreamer-1.0 gstreamer-app-1.0
```

ldd
====
* Get all dependencies of an executable
```sh
ldd /bin/ffmpeg
```
* Copy all dependencies to current folder
```sh
ldd /bin/ffmpeg | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' .
```

Static compile (To be continued)
=====
* Make sure libs are compiled as .a format not .so or .dll format
```sh
gcc -static
```

Cross compile with sysroot
=====
```sh
export LDFLAGS="--sysroot=$MYSYSROOT $LDFLAGS"
export CFLAGS="--sysroot=$MYSYSROOT $CFLAGS"
# Or
export CC="aarch64-linux-gcc --sysroot=$MYSYSROOT"
```

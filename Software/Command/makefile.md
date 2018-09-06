pkg-config
=====
* Get all includes and libs path
```sh
pkg-config --list-all | grep gstreamer
pkg-config --cflags --libs gstreamer-1.0 gstreamer-app-1.0
```

ldd
====
* Get all dependencies of a executable
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

Make / Writable
=====
```sh
/system/bin/mount -o rw,remount /
mkdir /opt
mkdir /bin
ln -s /system/bin/sh /bin/sh
# Make it Read-only again
/system/bin/mount -o ro,remount /
```

Unpack and install a .apk file
=====
* $ wget http://dl-cdn.alpinelinux.org/alpine/edge/testing/x86/apk-tools-static-xxx.apk
* $ tar zxvf apk-tools-static-xxx.apk
* Or
* $ mkdir ./extract && tar zxvf apk-tools-static-xxx.apk -C ./extract
* $ mkdir -p /lib/apk/db
* $ mkdir -p /var/cache/apk
* $ mkdir -p /etc/apk/world
* $ mkdir -p /etc/apk/world.new
* $ ./apk-tools-static add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk # NOT WORKING

List of static binary packages
======
* busybox-static
* apk-tools-static


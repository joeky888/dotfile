
## Install opkg to /data/data/ru.iiec.pydroid3/files (opkg update && opkg install xxx)
* Pydroid 3 (terminal for Android 4.4+, `chmod 777 aria2c && cp aria2c /data/data/ru.iiec.pydroid3/files/aria2c`)
    * Download http://pkg.entware.net/binaries/armv7/installer/opkg
    * Install opkg to /data/data/ru.iiec.pydroid3/files (opkg update && opkg install xxx)

```sh
# Copied from entware_install.sh
echo "Info: Opkg package manager deployment..."
CURARCH="armv7"
DLOADER="ld-linux.so.3"
URL=http://pkg.entware.net/binaries/$CURARCH/installer
OPT="/data/data/ru.iiec.pydroid3/files"
wget $URL/opkg -O $OPT/bin/opkg
chmod +x $OPT/bin/opkg
wget $URL/opkg.conf -O $OPT/etc/opkg.conf
wget $URL/ld-2.23.so -O $OPT/lib/ld-2.23.so
wget $URL/libc-2.23.so -O $OPT/lib/libc-2.23.so
wget $URL/libgcc_s.so.1.2.23 -O $OPT/lib/libgcc_s.so.1
cd $OPT/lib
chmod +x ld-2.23.so
ln -s ld-2.23.so $DLOADER
ln -s libc-2.23.so libc.so.6
```

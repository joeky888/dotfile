Install latest packages
=====
* Edit /etc/apt/sources.list
* Add "deb http://ftp.<COURTRY>.debian.org/debian/ stretch main contrib non-free"
```debsources
deb http://ftp.tw.debian.org/debian/ stretch main contrib non-free
```

Enable multi-architecture
=====
* $ sudo dpkg --add-architecture i386

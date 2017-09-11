Install latest packages
=====
* $ sudoedit /etc/apt/sources.list
* Add "deb http://ftp.<COUNRTRY>.debian.org/debian/ stretch main contrib non-free"
```debsources
deb http://ftp.tw.debian.org/debian/ unstable main contrib non-free
```

Enable multi-architecture
=====
* $ sudo dpkg --add-architecture i386

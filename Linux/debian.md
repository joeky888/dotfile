Install latest packages
=====
* $ sudoedit /etc/apt/sources.list
* Add "deb http://ftp.<COUNTRY>.debian.org/debian/ unstable main contrib non-free"
```debsources
deb http://ftp.tw.debian.org/debian/ unstable main contrib non-free
deb http://deb.debian.org/debian unstable-updates main contrib non-free
deb http://security.debian.org/ unstable/updates main contrib non-free
```

Enable multi-architecture
=====
* $ sudo dpkg --add-architecture i386

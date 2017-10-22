Download iso
=====
* Download debian-netinst.iso and debian firmware.zip
* Burn debian-netinst.iso to USB drive
* unzip firmware.zip to both / and /firmware of the USB drive

Install latest packages
=====
* Download debian iso with non-free firmware
* unstable > testing > stable
* $ sudoedit /etc/apt/sources.list
* Add "deb http://ftp.<COUNTRY>.debian.org/debian/ unstable main contrib non-free"
```debsources
# unstable, there is no security update for unstable
deb http://ftp.tw.debian.org/debian/ unstable main contrib non-free

# testing
deb http://ftp.tw.debian.org/debian/ testing main contrib non-free
deb http://ftp.tw.debian.org/debian testing-updates main contrib non-free
deb http://security.debian.org/ testing/updates main contrib non-free
```

Enable multi-architecture
=====
* $ sudo dpkg --add-architecture i386

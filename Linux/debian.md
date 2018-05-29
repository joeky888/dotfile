Download iso
=====
* Download debian-netinst.iso and /cdimage/unofficial/non-free/firmware/unstable/current/firmware.zip
* Burn debian-netinst.iso to USB drive
* unzip firmware.zip to both / and /firmware of the USB drive

Sudo
====
* $ adduser joeky sudo
* Or
* $ apt install sudo
* $ visudo
```sudoers
##
## User privilege specification
##
root  ALL=(ALL) ALL
joeky ALL=(ALL) ALL
Defaults timestamp_timeout=-1
```

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

Install Nvidia driver (Epic fail!!)
=====
* $ sudo apt purge xserver-xorg-video-nouveau -y
* $ sudo aptitude install nvidia-driver bumblebee-nvidia primus -y
* $ sudo systemctl enable bumblebeed && sudo systemctl start bumblebeed
* $ sudo rm /etc/X11/xorg.conf
* $ sudo nvidia-xconfig
* $ sudo optirun nvidia-settings -c :8
* $ sudo update-grub && sudo update-grub2

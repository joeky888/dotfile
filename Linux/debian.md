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
```debsources
# unstable
deb http://cdn-fastly.deb.debian.org/debian/ unstable main contrib non-free

# testing
deb http://cdn-fastly.deb.debian.org/debian/ testing main contrib non-free
deb http://cdn-fastly.deb.debian.org/debian-security testing-security main contrib non-free

### Debug only ###
deb http://cdn-fastly.deb.debian.org/debian-debug testing-debug main contrib non-free
```

Enable multi-architecture
=====
* $ sudo dpkg --add-architecture i386

Install xfce4
=====
* Method 1
    * Just use debian xfce live iso
* Method 2 - minimal installation
    * $ app-fast install xfce4 xfce4-terminal lightdm ; sudo apt purge light-locker -y
* Method 3 - full installation
    * $ app-fast install xfce4-goodies ; sudo apt purge light-locker -y
```sh
echo "exec startxfce4" > ~/.xinitrc

# Auto login
sudo groupadd -r autologin
sudo gpasswd -a $(whoami) autologin
echo "[SeatDefaults]" | sudo tee -a /etc/lightdm/lightdm.conf
echo "autologin-user=$(whoami)" | sudo tee -a /etc/lightdm/lightdm.conf
echo "autologin-user-timeout=0" | sudo tee -a /etc/lightdm/lightdm.conf
echo "autologin-session=xfce" | sudo tee -a /etc/lightdm/lightdm.conf

sudo reboot
```

Install Nvidia driver (Epic fail!!)
=====
* $ sudo apt purge xserver-xorg-video-nouveau -y
* $ sudo aptitude install nvidia-driver bumblebee-nvidia primus -y
* $ sudo systemctl enable bumblebeed && sudo systemctl start bumblebeed
* $ sudo rm /etc/X11/xorg.conf
* $ sudo nvidia-xconfig
* $ sudo optirun nvidia-settings -c :8
* $ sudo update-grub

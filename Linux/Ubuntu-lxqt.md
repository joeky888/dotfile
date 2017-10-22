Get latest ubuntu package
=====
* $ sudo do-release-upgrade -d
* $ sudoedit /etc/apt/sources.list
* Replace all "xenial" (or something like that) strings with "devel"

Config CJK font in tty
=====
* $ sudo apt-fast install fbterm fontconfig -y
* $ sudo apt-fast install virtualbox-guest-dkms -y # for virtualbox
* $ sudo fc-cache -fv
* $ fc-list # Check font is installed or not
* $ sudo chmod u-s $(which fbterm) # If try to use fbterm hotkeys, use "u+s" instead
* $ sudo usermod -a -G video $(whoami)
* $ sudo reboot

Mount a USB drive
=====
* $ lsblk
* $ sudo blkid
* $ sudo fdisk -l
* $ sudo mkdir /media/usb
* $ sudo mount /dev/sdb1 /media/usb
* $ sudo umount /media/usb

Change tty resolution
=====
* $ sudo apt-fast install virtualbox-guest-dkms -y
* Reboot OS, when it shows boot menu, type "c" switch to grub mode
* $ grub> vbeinfo
* Pick one from stdout, ex: 1024x768x16
* $ grub> reboot
* $ sudoedit /etc/default/grub && sudo update-grub && sudo update-grub2
```conf
# In this order
GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"
GRUB_CMDLINE_LINUX=""
GRUB_GFXMODE=1024x768x16
GRUB_GFXPAYLOAD_LINUX=1024x768x16
```
* $ sudo reboot

Change timezone
=====
* $ timedatectl list-timezones | grep Asi
* $ sudo timedatectl set-timezone Asia/Taipei

Listen to music without x
=====
* $ sudo apt-fast install alsa alsa-tools vlc-nox -y
* $ sudo usermod -a -G audio $(whoami)
* $ sudo reboot
* $ alsamixer # Adjust volume
* $ vlc -I ncurses --random ~/Music/\*.mp3
* If there is no sound in virtualbox, switch the audio card in virtualbox setting

Mouse without x
=====
* Make sure fbterm is installed and functional
* $ sudo apt-fast install gpm
* $ sudo reboot

Connect network using static ip
=====
* Get netword card name
* $ ifconfig -a
* if the name is wlan0
```conf
auto wlan0
iface wlan0 inet static
address 192.168.1.150
netmask 255.255.255.0
gateway 192.168.1.1
```
* $ sudo systemctl restart networking

Connect network using dynamic ip
=====
* Get netword card name
* $ ifconfig -a
* if the name is wlan0
* $ sudoedit /etc/network/interfaces
```conf
auto wlan0
iface wlan0 inet dhcp
wpa-ssid <your_router>
wpa-psk <your_wpa_key>
```
* $ sudo systemctl restart networking

Add dns server
=====
* $ sudoedit /etc/resolv.conf
* Or
* $ sudoedit /run/resolvconf/resolv.conf
* Or
* $ sudoedit /etc/resolvconf/resolv.conf.d/head
```resolv
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 123.193.111.11
nameserver 123.193.111.69
nameserver 223.5.5.5
```
* $ sudo resolvconf -u

Install LXQT
=====
* $ sudo apt-fast install lxqt xorg openbox compton gnome-terminal chromium-codecs-ffmpeg-extra vim-gtk3 network-manager network-manager-gnome file-roller software-properties-kde baobab gnome-system-monitor gnome-disk-utility -y && sudo apt-fast purge connman -y
* $ lxqt-config-appearance # Select dark theme
* Or using ppa
* $ sudo add-apt-repository ppa:lxqt/ppa -y
* $ sudo apt-fast update
* $ sudo apt-fast install lxqt

Disable suspend when closing laptop lid
=====
* $ sudoedit /etc/systemd/logind.conf
```conf
HandleLidSwitch=ignore
```
* $ sudo systemctl restart systemd-logind

Transparet background with openbox
=====
* $ sudo apt-fast install compton
* $ ln -sf ~/dotfile/Linux/compton.conf ~/.config/compton.conf
* $ lxqt-config-session
* Go to Autostart tab and add a new command
* Name: Compton
* Command: compton -CGb --config ~/.config/compton.conf
* $ sudo reboot

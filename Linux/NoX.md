Install Fbterm
=====
* $ sudo apt remove fbterm -y
* $ app-fast install libgpm-dev libfontconfig1-dev libfreetype6-dev libx86-dev pkg-config -y
* $ git clone --depth 1 https://github.com/joeky888/fbterm.git && cd fbterm
* $ ./configure && make && sudo make install
* $ app-fast install fontconfig -y
* $ app-fast install virtualbox-guest-dkms -y # for virtualbox
* $ sudo fc-cache -fv
* $ fc-list # Check font is installed or not
* $ sudo chmod u-s $(which fbterm) # If try to use fbterm hotkeys, use "u+s" instead
* $ sudo usermod -aG video $(whoami)
* Reboot OS, when it shows boot menu, type "c" switch to grub mode
* $ grub> vbeinfo # Or videoinfo
* Pick one from stdout, ex: 1024x768x16
* $ grub> reboot
* $ sudoedit /etc/default/grub && sudo update-grub
```conf
# In this order
GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"
GRUB_CMDLINE_LINUX=""
GRUB_GFXMODE=1024x768x16
GRUB_GFXPAYLOAD_LINUX=1024x768x16
```
* $ sudo reboot

Install yaft (yet another framebuffer terminal)
=====
* $ git clone --depth 1 https://github.com/uobikiemukot/yaft
* $ make
* $ sudo ./yaft

Change the default 16 colors of fbterm
=====
```conf
# Edit fbtermrc file
color-foreground=7
color-background=0
color-0=000000
color-1=AA0000
color-2=00AA00
color-3=AA5500
color-4=0000AA
color-5=AA00AA
color-6=00AAAA
color-7=AAAAAA
color-8=555555
color-9=FF5555
color-10=55FF55
color-11=FFFF55
color-12=5555FF
color-13=FF55FF
color-14=55FFFF
color-15=FFFFFF
```

Mouse without x
=====
* Make sure fbterm is installed and functional
* $ app-fast install gpm -y
* $ sudo systemctl enable gpm
* Left mouse click is Copy
* Right mouse click is Paste
* If mouse is not available in vim
    * $ vim --version | grep gpm # Check vim gpm support
    * :set mouse=a
    * :set ttymouse=xterm
    * Edit .tmux.conf
    * set -g mouse off

Boot without X Desktop
=====
* Temporary
    * Boot
    * When grub shows, press E
    * Add `3` to the end of the line `linux /boot/vmlinuzxxx`
```conf
linux /boot/vmlinuz-4.10-x86_64 root=UUID=85460fc6-666d-4be2-88a6-b0ef8c01b532 rw quiet resume=UUID=2e69bc09-e974-4568-9675-5293031cfd40 3
```
    * Ctrl-X to save and boot
* Permanent
    * Add `3` to the `GRUB_CMDLINE_LINUX_DEFAULT`
    * $ sudoedit /etc/default/grub && sudo update-grub
```conf
GRUB_CMDLINE_LINUX_DEFAULT="quiet 3"
# Or just
GRUB_CMDLINE_LINUX_DEFAULT="3"
```

Mount a USB drive
=====
* $ lsblk
* $ sudo blkid
* $ sudo fdisk -l
* $ sudo mkdir /media/usb
* $ sudo mount /dev/sdb1 /media/usb
* $ sudo umount /media/usb

Clear cache
=====
```sh
rm -rf ~/.cache
sudo rm /var/cache/apt/archives/*
sudo rm /var/cache/pacman/pkg/*
```

Change timezone
=====
* Method 1
    * $ timedatectl list-timezones | grep Asi
    * $ sudo timedatectl set-timezone Asia/Taipei
* Method 2
    * $ `export DEBIAN_FRONTEND=noninteractive && sudo apt install -y tzdata`
    * $ sudo ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
    * $ sudo echo "Asia/Taipei" > /etc/timezone
    * $ sudo dpkg-reconfigure --frontend noninteractive tzdata

Listen to music without x
=====
* $ app-fast install alsa alsa-tools vlc-nox -y
* $ sudo usermod -a -G audio $(whoami)
* $ sudo reboot
* $ alsamixer # Adjust volume
* $ vlc -I ncurses --random ~/Music/\*.mp3
* If there is no sound in virtualbox, switch the audio card in virtualbox setting

Show images without x
=====
* See w3m.md

Show all network interfaces
=====
* $ ip a
* $ ip address
* $ ifconfig -a
* $ nmcli device show

NetworkManager without X
=====
* $ nmtui # Or
* $ nmcli device show | grep CONNECTION # Get device name
* $ sudoedit "/etc/NetworkManager/system-connections/${DeviceName}" # TODO
* $ sudo systemctl restart NetworkManager

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

DHCP on archlinux
=====
```sh
ip a # Get interface name, EX. eth0
sudo dhcpcd eth0
sudo pacman -Syyu
```

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
* $ nmcli connection show
* $ nmcli connection mod <CONNECTION-NAME> ipv4.dns "8.8.8.8 8.8.4.4"
* Or
* $ sudoedit /etc/resolvconf.conf && sudo resolvconf -u
```resolv
name_servers="180.76.76.76 114.114.114.114 8.8.4.4 8.8.8.8"
```
* Or
* $ sudoedit /etc/resolv.conf
* Or
* $ sudoedit /run/resolvconf/resolv.conf
* Or
* $ sudoedit /etc/resolvconf/resolv.conf.d/head
```resolv
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 180.76.76.76
nameserver 114.114.114.114
```
* $ sudo resolvconf -u

Add an user to sudoer group
=====
* $ sudo usermod -aG sudo joeky
* Or
* $ sudo gpasswd -a joeky sudo
* Or
* $ sudo adduser joeky sudo

Get log of systemd
=====
* With time range
* $ sudo journalctl --since "2018-08-30 14:10:10" --until "2018-09-02 12:05:50" -u SERVICE-NAME.service

Clear system log greater than 10MB
=====
* $ sudo journalctl --vacuum-size=10M

Get nvidia gpu usage
=====
* $ nvidia-smi
* Or
* $ nvidia-smi -l 1 # Refresh interval of 1 second

List installed kernel drivers
=====
* $ lspci -knn

Install wi-fi driver (usb wifi adapter)
=====
* For Ubuntu
* $ app-fast install rtl8812au-dkms # Try r8168-dkms if it doesn't work
* For others
    * Enable security boot (because open source drivers are not signed)
    * Reboot
    * Compile and install rtl8812au-dkms from source
    * $ sudo modprobe -a rtl8812au

cat, more, less and cmd.exe type command with color
=====
```sh
# file.txt
[30mTEXT[39m
[31mTEXT[39m
[32mTEXT[39m
[33mTEXT[39m
[34mTEXT[39m
[35mTEXT[39m
[36mTEXT[39m
[37mTEXT[39m
[90mTEXT[39m
[91mTEXT[39m
[92mTEXT[39m
[93mTEXT[39m
[94mTEXT[39m
[95mTEXT[39m
[96mTEXT[39m
[97mTEXT[39m

[40mTEXT[49m
[41mTEXT[49m
[42mTEXT[49m
[43mTEXT[49m
[44mTEXT[49m
[45mTEXT[49m
[46mTEXT[49m
[47mTEXT[49m
[100mTEXT[49m
[101mTEXT[49m
[102mTEXT[49m
[103mTEXT[49m
[104mTEXT[49m
[105mTEXT[49m
[106mTEXT[49m
[107mTEXT[49m

echo "\u001b[30mTEXT\u001b[39m"
echo "\u001b[31mTEXT\u001b[39m"
echo "\u001b[32mTEXT\u001b[39m"
echo "\u001b[33mTEXT\u001b[39m"
echo "\u001b[34mTEXT\u001b[39m"
echo "\u001b[35mTEXT\u001b[39m"
echo "\u001b[36mTEXT\u001b[39m"
echo "\u001b[37mTEXT\u001b[39m"
echo "\u001b[90mTEXT\u001b[39m"
echo "\u001b[91mTEXT\u001b[39m"
echo "\u001b[92mTEXT\u001b[39m"
echo "\u001b[93mTEXT\u001b[39m"
echo "\u001b[94mTEXT\u001b[39m"
echo "\u001b[95mTEXT\u001b[39m"
echo "\u001b[96mTEXT\u001b[39m"
echo "\u001b[97mTEXT\u001b[39m"

echo "\u001b[40mTEXT\u001b[49m"
echo "\u001b[41mTEXT\u001b[49m"
echo "\u001b[42mTEXT\u001b[49m"
echo "\u001b[43mTEXT\u001b[49m"
echo "\u001b[44mTEXT\u001b[49m"
echo "\u001b[45mTEXT\u001b[49m"
echo "\u001b[46mTEXT\u001b[49m"
echo "\u001b[47mTEXT\u001b[49m"
echo "\u001b[100mTEXT\u001b[49m"
echo "\u001b[101mTEXT\u001b[49m"
echo "\u001b[102mTEXT\u001b[49m"
echo "\u001b[103mTEXT\u001b[49m"
echo "\u001b[104mTEXT\u001b[49m"
echo "\u001b[105mTEXT\u001b[49m"
echo "\u001b[106mTEXT\u001b[49m"
echo "\u001b[107mTEXT\u001b[49m"

# file.txt

cat  file.txt
more file.txt
less file.txt

# On windows cmd.exe
type file.txt
```

Web browser without X
=====
* Install firefox
* Download browsh

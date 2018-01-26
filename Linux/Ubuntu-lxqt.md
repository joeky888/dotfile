Get latest ubuntu package
=====
* $ sudo do-release-upgrade -d
* $ sudoedit /etc/apt/sources.list
* Replace all "xenial" (or something like that) strings with "devel"
* $ sudo add-apt-repository "deb http://archive.canonical.com/ devel partner"

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
nameserver 180.76.76.76
nameserver 114.114.114.114
```
* $ sudo resolvconf -u

Install LXQT
=====
* $ sudo apt-fast install lxqt xorg openbox compton chromium-codecs-ffmpeg-extra shutter opencc vim-gtk3 nomacs network-manager network-manager-gnome file-roller software-properties-gtk baobab gnome-system-monitor gnome-disk-utility -y && sudo apt-fast purge connman xarchiver vim fbterm -y
* $ lxqt-config-appearance # Select dark theme

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

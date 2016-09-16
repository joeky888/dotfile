Config CJK font in tty
=====
* $ sudo apt-get install ttf-ubuntu-font-family fonts-droid-fallback fbterm -y
* $ sudo apt-get install virtualbox-guest-dkms -y # for virtualbox
* $ sudo fc-cache -fv
* $ fc-list # Check font is installed or not
* $ sudo chmod u+s $(which fbterm)
* $ sudo usermod -a -G video $(whoami)
* $ vim ~/.bash_profile, replace "exec tmux" to "fbterm tmux"
* Ctrl+D to logout
* $ vim ~/.fbtermrc
````
font-name=Ubuntu Mono, Droid Sans Fallback
font-size=18
````
* $ sudo reboot

Connect network using static ip
=====
* Get netword card name
* $ ifconfig -a
* if the name is wlan0
````
auto wlan0
iface wlan0 inet static
address 192.168.1.150
netmask 255.255.255.0
gateway 192.168.1.1
````
* $ sudo systemctl restart networking

Connect network using dynamic ip
=====
* Get netword card name
* $ ifconfig -a
* if the name is wlan0
* Edit /etc/network/interfaces
````
auto wlan0
iface wlan0 inet dhcp
wpa-ssid <your_router>
wpa-psk <your_wpa_key>
````
* $ sudo systemctl restart networking

Add dns server
=====
* Edit /etc/resolvconf/resolv.conf.d/head
````
nameserver 8.8.8.8                                            
nameserver 140.118.31.31
````
* $ sudo resolvconf -u

Get latest ubuntu package
=====
* Edit /etc/apt/sources.list
* Replace all "vivid" (or something like that) strings to "devel"

Install LXQT
=====
* sudo apt-get install lxqt

Install dotfile
=====
* $ ./install.py linux

Disable suspend when closing laptop lid
=====
* Edit /etc/systemd/logind.conf
````
HandleLidSwitch=ignore
````
* $ sudo systemctl restart systemd-logind
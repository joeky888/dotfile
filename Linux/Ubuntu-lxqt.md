Get latest ubuntu package
=====
* $ sudo do-release-upgrade -d
* $ sudoedit /etc/apt/sources.list
* Replace all "xenial" (or something like that) strings with "devel"
* $ sudo add-apt-repository "deb http://archive.canonical.com/ devel partner"

Install LXQT
=====
* $ app-fast install lxqt xorg openbox compton chromium-codecs-ffmpeg-extra shutter opencc vim-gtk3 nomacs network-manager network-manager-gnome file-roller software-properties-gtk baobab gnome-system-monitor gnome-disk-utility -y && sudo apt purge connman xarchiver vim -y
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
* $ app-fast install compton
* $ ln -sf ~/dotfile/Linux/compton.conf ~/.config/compton.conf
* $ lxqt-config-session
* Go to Autostart tab and add a new command
* Name: Compton
* Command: compton -CGb --config ~/.config/compton.conf
* $ sudo reboot

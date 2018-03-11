After installed
=====
* Setting -> Power Management -> Disable computer auto sleeping
* Setting -> Power Management -> Disable suspend on lid closed
* Setting -> Account -> auto login
* Setting -> Update -> Update Settings -> Auto-download Updates -> Check
* Desktop right click -> Corner Settings -> set right bottom corner to "Desktop"
* $ sudoedit /etc/apt/sources.list -> Use "unstable"
```debsources
deb [by-hash=force] http://ftp.ubuntu-tw.org/mirror/deepin/ unstable main contrib non-free universe
# This one is optional
deb http://ftp.tw.debian.org/debian/ unstable main contrib non-free
```

Theme
=====
* Display -> Personalization -> Theme -> Deepin-dark
* Display -> Personalization -> Uncheck Enable window effect
* Keyboard and Language -> Uncheck Caps Lock Prompt
* Terminal theme
    * Click setting button -> Switch theme -> Tango
* Dock theme
    * Right click on the dock -> Mode -> Efficient Mode

Add dns server
=====
* $ sudoedit /var/run/NetworkManager/resolv.conf
* Or
* $ sudoedit /etc/resolv.conf
* Or
* $ sudoedit /run/resolvconf/resolv.conf
* Or
* $ sudoedit /etc/resolvconf/resolv.conf.d/head
```resolv
nameserver 8.8.4.4
nameserver 180.76.76.76
nameserver 8.8.8.8
nameserver 114.114.114.114
```
* $ sudo resolvconf -u

Add apt-get proxy
=====
* $ sudoedit /etc/apt/apt.conf
```conf
Acquire::http::Proxy "http://username:password@proxy.hinet.net:80";
```

Packages
=====
* $ sudo apt-fast install sogoupinyin adb fastboot opera-developer opera-stable vscode teamviewer qpdfview evince nomacs vlc obs-studio earlyoom console-setup deepin-graphics-driver-manager deepin-repair-tools deepin-system-monitor deepin.com.baidu.pan opencc vim-gtk3 file-roller software-properties-gtk baobab gnome-system-monitor gnome-disk-utility -y && sudo apt purge vim foxitreader spotify-client -y
* $ cat $HOME/dotfile/Software/sogou.ini > ~/.config/SogouPY/phrase/PhraseEdit.txt
* Dowload the LibreOffice.appimage
* $ sudoedit /etc/systemd/system/earlyoom.service
```conf
# Use 97% of ram
ExecStart=/usr/bin/earlyoom -m 3
```

Disable Gnome keyring when opening the browser
=====
* $ sudo apt install seahorse -y
* $ seahorse

Install Zhuyin IM
=====
* $ sudo apt install gcin # or hime
* $ im-config -n gcin
* $ sudo reboot

Nvidia driver
=====
* Don't use bumblebee
* $ deepin-graphics-driver-manager

Run Android apk files
=====
* $ sudo apt-fast install archon-integration deepin-archon -y
```sh
AndroidApkRun(){
  apk=$1
  if [ -z $apk ];then
    echo "apk needed."
    exit 1
  fi
  ret=$(/usr/lib/node_modules/chromeos-apk/chromeos-apk --archon -t --scale --name "Android App" "$apk")
  ret=${ret#Directory \" }
  ret=${ret% \" created*}
  /lastore/framework/myarchon/archonrun --silent-launch --load-and-launch-app=$ret
}
```
* $ AndroidApkRun xxx.apk

Install Line
=====
* Install Line Chrome App, don't use wine to do this

Install conky
=====
* $ sudo apt-fast install conky conky-manager -y
* $ conky-manager

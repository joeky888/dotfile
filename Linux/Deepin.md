After installed
=====
* Setting -> Power Management -> Disable computer auto sleeping
* Setting -> Account -> auto login
* Setting -> Update -> Update Settings -> Auto-download Updates -> Check
* Desktop right click -> Corner Settings -> set right bottom corner to "Desktop"
* $ sudoedit /etc/apt/sources.list -> Use "unstable"
```debsources
deb [by-hash=force] http://ftp.ubuntu-tw.org/mirror/deepin/ unstable main contrib non-free universe
```

Theme
=====
* Display -> Personalization -> Theme -> Deepin-dark
* Display -> Personalization -> Uncheck Enable window effect
* Keyboard and Language -> Uncheck Caps Lock Prompt
* Terminal theme
    * Click setting button -> Switch theme -> elementary
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

Packages
=====
* $ sudo apt-fast install sogoupinyin opera-developer opera-stable vscode teamviewer vlc xnview obs-studio deepin-graphics-driver-manager deepin-system-monitor deepin.com.baidu.pan opencc vim-gtk3 file-roller software-properties-gtk baobab gnome-system-monitor gnome-disk-utility -y && sudo apt purge vim -y

Nvidia driver (Don't do it!!! bumblebee is deprecated!!!)
=====
* $ `sudo apt remove nvidia-* -y`
* $ sudo apt-get install bumblebee-nvidia nvidia-driver nvidia-settings -y
* Check driver is installed successfully
* $ sudo apt-fast install mesa-utils -y
* $ optirun glxinfo | grep NVIDIA
* $ optirun glxgears -info # Test bumblebee
* Open a program with Nvidia driver, Ex: firefox
    * $ Primusrun firefox
    * Or
    * $ optirun firefox
* If error "You do not appear to be using the NVIDIA X driver" appears
    * $ optirun -b none nvidia-settings -c :8

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

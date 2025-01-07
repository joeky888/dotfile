ANI CLI
=====
* $ ANI_CLI_PLAYER=android_vlc bash ./ani-cli --dub one punch

Install manjaro using proot
=====
```sh
pkg i proot-distro
pd list
pd install manjaro

pd login manjaro --termux-home --shared-tmp -- /bin/fish
pacman-mirrors --api --set-branch stable --protocols https --continent

pd remove manjaro # Uninstall: Remove chroot
```

Install yt-dlp and streamlink
=====
* Install miniforge3 in proot


Install nodejs inside proot manjaro
=====
* Put `fnm` to ~/bin
```
fnm install --lts
fnm use lts/latest
```

Install udocker and Cloudbeaver inside proot manjaro (Failed!!!)
=====
* Install bash `pacman -S bash` and make sure /bin/bash exists
* Install miniforge3
```sh
conda install udocker

# Note: dbeaver/cloudbeaver-ee:latest works
#       dbeaver/cloudbeaver-ee:24.3.1 fails
# So search tags first!!!
udocker --allow-root search --list-tags dbeaver/cloudbeaver-ee # Pick a tag
mkdir -p /cloudbeaver
udocker --allow-root run -p 8080:8978 -v /cloudbeaver:/opt/cloudbeaver/workspace dbeaver/cloudbeaver-ee:pick-a-tag

curl http://localhost:8080
```

Manjaro with XFCE (Don't try this, UX is terrible)
=====
```sh
pacman -S sudo vim
useradd -mG root -s /bin/bash joeky
passwd joeky
nano /etc/sudoers
  joeky ALL=(ALL) ALL # Add this line
su joeky
sudo pacman -S vim networkmanager xorg xorg-server pulseaudio noto-fonts-cjk git openssh fakeroot base-devel xfce4 xfce4-goodies lightdm pamac-cli

exit
```
* Install Termux Widget from f-droid
* $ apt install -y x11-repo
* $ apt install -y termux-x11-nightly
* $ apt install -y virglrenderer-android
* $ mkdir -p ~/.shortcuts && nano ~/.shortcuts/start_manjaro.sh # Do it but not in proot manjaro
```bash
#!/bin/bash

# 中止所有舊行程
killall -9 termux-x11 Xwayland pulseaudio virgl_test_server_android termux-wake-lock

# 啟動Termux X11
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 -ac &
sleep 3

# 啟動PulseAudio
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

# 啟動GPU加速的virglserver
virgl_test_server_android &

# 登入proot Arch Linux，並啟動PulseAudio、Fcitx5、桌面環境
proot-distro login manjaro --user joeky --shared-tmp -- /bin/bash -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && dbus-launch --exit-with-session startxfce4"
```
* $ chmod +x ~/.shortcuts/start_manjaro.sh
* Settings -> Developers options -> Enable `Allow screen overlays`
* Settings -> Apps -> Termux -> Permissions -> ... (On the top right) -> All permissions -> Enable `Display Over Other Apps`
* Go to desktop -> Add widget -> Termux Widget -> Shoud show `start_manjaro.sh`
* Install https://github.com/termux/termux-x11/releases
  * Download app-arm64-v8a-debug.apk
* Exit termux
* Launch termux X11 in the background
* Click termux widget on the desktop
  * If xfce4 panel (toolbar on the top of desktop) doesn't show up -> Open xfce terminal and run this command once $ xfce4-panel


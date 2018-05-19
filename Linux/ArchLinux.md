Pacman
=====
* Remove a package
    * $ sudo pacman -Qdtq | sudo pacman -Rs -
* Download only
    * $ pacman -Sw package
    * $ /var/cache/pacman/pkg # Find the package

Use aria2 as backend of pacman
=====
* pacman -S mingw64/mingw-w64-x86\_64-aria2
* Edit /etc/pacman.conf
* XferCommand = aria2c -c -s16 -k1M -x16 --dir=/ -o %o %u

CN packages like baidu pan
=====
* sudoedit /etc/pacman.conf
```dosini
[archlinuxcn]
SigLevel = Never
Server = https://cdn.repo.archlinuxcn.org/$arch
```
```sh
sudo pacman -Syy && sudo powerpill -S --noconfirm --needed archlinuxcn-keyring
sudo powerpill -S --noconfirm --needed visual-studio-code-bin teamviewer skypeforlinux-stable-bin ttf-wps-fonts wps-office ttf-iosevka-term
```

Unstable and testing package (Manjaro)
=====
* $ sudo pacman-mirrors --api --set-branch testing # Or unstable

Install virtualbox
=====
* $ uname -a # Get kernel version
* $ sudo powerpill -S virtualbox
* $ sudo powerpill -S [kernel version]-virtualbox-host-modules
* $ sudo modprobe vboxdrv
* $ sudo gpasswd -a $(whoami) vboxusers

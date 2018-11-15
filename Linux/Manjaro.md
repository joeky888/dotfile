Install without desktop
=====
* Login as manjaro/manjaro
* $ nmtui # Or edit file directly, see ~/dotfile/Linux/NoX.md
* $ setup

Pacman
=====
* Upgrade packages
    * $ sudo powerpill -Syyu ; sudo pacman -Rsc $(pacman -Qdtq)
* Download only
    * $ pacman -Sw package
    * $ /var/cache/pacman/pkg # Find the package
* Upgrade all AUR packages
    * $ yay -Syyu --aur

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
* $ sudo pacman-mirrors -f 0

Boot without X desktop
=====
* Boot
* When grub shows, press E
* Add `3` to the end of the line `linux /boot/vmlinuzxxx`
```conf
linux /boot/vmlinuz-4.10-x86_64 root=UUID=85460fc6-666d-4be2-88a6-b0ef8c01b532 rw quiet resume=UUID=2e69bc09-e974-4568-9675-5293031cfd40 3
```
* Ctrl-X to save and boot

Install fbterm (recommand)
=====
* $ yay -S fbterm-git
* $ sudo chmod u-s $(which fbterm)
* $ sudo usermod -a -G video $(whoami)
* $ sudo powerpill -S gpm libx86
* $ sudo systemctl enable gpm

Install qemu
=====
* $ sudo powerpill -S qemu-arch-extra

Install virtualbox
=====
* $ uname -a # Get kernel version
* $ sudo powerpill -S virtualbox
* $ sudo powerpill -S [kernel version]-virtualbox-host-modules
* $ sudo modprobe vboxdrv
* $ sudo gpasswd -a $(whoami) vboxusers

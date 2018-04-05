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
Server = https://cdn.repo.archlinuxcn.org/$arch
```
* sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring
* sudo pacman -S deepin-baidu-pan

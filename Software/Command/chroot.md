Alpine Linux
=====
* Download Mini root filesystem
* https://alpinelinux.org/downloads/
```sh
mkdir -p $HOME/Alpine
tar zxvf alpine.tar.gz -C $HOME/Alpine
sudo chroot $HOME/Alpine /bin/bash -l
```

Arch / Manjaro
=====
```sh
sudo powerpill -S arch-install-scripts
mkdir $HOME/Arch

sudo pacstrap -cdGM $HOME/Arch base filesystem pacman linux powerpill
sudoedit $HOME/Arch/etc/pacman-mirrors.conf
sudo cp $(command -v arch-chroot) $HOME/Arch/bin
sudo $HOME/Arch/bin/arch-chroot $HOME/Arch /bin/bash -l
# or
sudo chroot $HOME/Arch /bin/bash -l # Not recommand
```

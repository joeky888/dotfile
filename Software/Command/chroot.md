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

sudo pacstrap -cdGM $HOME/Arch filesystem pacman
sudoedit $HOME/Arch/etc/pacman-mirrors.conf

sudo chroot $HOME/Arch /bin/bash -l
```

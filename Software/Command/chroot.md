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
mkdir $HOME/arch

sudo pacstrap -cdGM $HOME/arch filesystem pacman
sudoedit $HOME/arch/etc/pacman-mirrors.conf

sudo chroot $HOME/arch /bin/bash -l
```

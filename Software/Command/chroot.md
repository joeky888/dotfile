Alpine Linux
=====
* Download Mini root filesystem
* https://alpinelinux.org/downloads/
```sh
mkdir -p $HOME/Alpine
tar zxvf alpine.tar.gz -C $HOME/Alpine
sudo chroot $HOME/Alpine /bin/bash -l
```

Arch / Manjaro (Failed)
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

sudo tar czvf arch.tar.gz $HOME/Arch
```

Debian
=====
```sh
sudo powerpill -S debootstrap

mkdir $HOME/Debian ; cd $HOME/Debian

# debootstrap --arch <ARCH> <VERSION> <DIRECTORY> <MIRROR>
#   <ARCH> = i386、amd64、armel、armhf
#   <MIRROR> = http://ftp.tw.debian.org/debian/
sudo debootstrap --arch amd64 unstable $PWD http://cdn-fastly.deb.debian.org/debian/

echo "deb http://cdn-fastly.deb.debian.org/debian/ unstable main contrib non-free" | sudo tee $PWD/etc/apt/sources.list

sudo tar czvf deb.tar.gz $HOME/Debian
```

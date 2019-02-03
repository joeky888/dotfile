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
sudo app-fast -S arch-install-scripts
mkdir $HOME/Arch

sudo pacstrap -cdGM $HOME/Arch base filesystem pacman linux
sudoedit $HOME/Arch/etc/pacman-mirrors.conf
sudo cp $(command -v arch-chroot) $HOME/Arch/bin
sudo $HOME/Arch/bin/arch-chroot $HOME/Arch /bin/bash -l
# or
sudo chroot $HOME/Arch /bin/bash -l # Not recommand

cd $HOME/Arch
sudo tar czvf ../arch.tar.gz . # Pack
sudo tar zxvf arch.tar.gz -C $HOME/Arch # Unpack
```

Debian
=====
```sh
sudo app-fast -S debootstrap

mkdir $HOME/Debian ; cd $HOME/Debian

# debootstrap --arch <ARCH> <VERSION> <DIRECTORY> <MIRROR>
#   <ARCH> = i386、amd64、armel、armhf、arm64
#   <MIRROR> = http://ftp.tw.debian.org/debian/
sudo debootstrap --arch amd64 unstable $PWD http://cdn-fastly.deb.debian.org/debian/

echo "deb http://cdn-fastly.deb.debian.org/debian/ unstable main contrib non-free" | sudo tee $PWD/etc/apt/sources.list
sudo install ~/dotfile/app-fast/app-fast $PWD/usr/bin

cd $HOME/Debian
sudo tar czvf ../deb.tar.gz . # Pack
sudo tar zxvf deb.tar.gz -C $HOME/Debian # Unpack
```

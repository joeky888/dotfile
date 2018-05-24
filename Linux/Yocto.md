Install Yocto Linux armv8 using qemu on Linux host
=====
* Download Yocto toolchain
    * Take version 2.5 for example
    * `http://downloads.yoctoproject.org/releases/yocto/yocto-2.5/toolchain/x86_64/poky-glibc-x86_64-core-image-sato-aarch64-toolchain-2.5.sh`
    * Execute .sh file will install toolchain to /opt of the host system
* Download Pre-built qemu kernel, qemu disk files and qemu conf
    * Take version 2.5 for example
    * kernel: `http://downloads.yoctoproject.org/releases/yocto/yocto-2.5/machines/qemu/qemuarm64/Image-qemuarm64.bin`
    * disk: `http://downloads.yoctoproject.org/releases/yocto/yocto-2.5/machines/qemu/qemuarm64/core-image-sato-qemuarm64.ext4`
    * conf: `http://downloads.yoctoproject.org/releases/yocto/yocto-2.5/machines/qemu/qemuarm64/core-image-sato-sdk-qemuarm64.qemuboot.conf`
```sh
# Init env variables
source /opt/poky/2.5/environment-setup-arch-poky-linux
# Make sure kernel, disk and conf files are in the same directory
runqemu qemuarm64 ./Image-qemuarm64.bin ./core-image-sato-qemuarm64.ext4
```

Install opkg file manager
=====
* Original tutorial here
    * https://github.com/Entware/Entware-ng/wiki/Install-on-Android
* Lauch the Yocto Linux, log in as root
```sh
mount -o rw,remount /
wget -O - http://pkg.entware.net/binaries/armv7/installer/entware_install.sh | sh
cd /opt/bin
./opkg update
```
* List of all available packages
    * armv5 - http://pkg.entware.net/binaries/armv5/Packages.html
    * armv7 - http://pkg.entware.net/binaries/armv7/Packages.html
    * mipsel - http://pkg.entware.net/binaries/mipsel/Packages.html
    * x86-32 - http://pkg.entware.net/binaries/x86-32/Packages.html
    * x86-64 - http://pkg.entware.net/binaries/x86-64/Packages.html

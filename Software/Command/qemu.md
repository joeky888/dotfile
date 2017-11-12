Install an arm iso
=====
* See [wiki](https://wiki.qemu.org/Documentation/Platforms/ARM)
* $ qemu-img create -f qcow2 disk.img 10G
* $ qemu-system-aarch64 -m 2048M -sd disk.img -M raspi2 -usbdevice mouse -usbdevice keyboard -drive format=raw,media=cdrom,readonly,file=debian-amd64-DVD-1.iso
* $ qemu-system-aarch64 -m 2048M -usbdevice mouse -usbdevice keyboard -drive format=qcow2,file=disk.img

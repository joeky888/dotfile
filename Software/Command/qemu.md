Install an arm iso
=====
* See [wiki](https://wiki.qemu.org/Documentation/Platforms/ARM)
* $ qemu-img create -f qcow2 disk.qcow2 10G
* $ qemu-system-aarch64 -m 2048M -sd disk.qcow2 -M virt -usb -device usb-host -drive format=raw,media=cdrom,readonly,file=debian-amd64-DVD-1.iso
* $ qemu-system-aarch64 -m 2048M -usb -device usb-host -drive format=qcow2,file=disk.qcow2

Install debian arm iso
=====
* See [wiki](https://wiki.qemu.org/Documentation/Platforms/ARM)
* Download debian arm64 iso
* Download vmlinuz and initrd.gz from [debian](http://ftp.debian.org/debian/dists/unstable/main/installer-armhf/current/images/netboot/)
* $ qemu-img create -f qcow2 disk.qcow2 10G
* $ qemu-system-aarch64 -m 1024M -sd disk.qcow2 -M versatilepb -show-cursor -cdrom debian-amd64-DVD-1.iso -kernel vmlinuz -initrd initrd.gz
* $ qemu-system-aarch64 -m 1024M -show-cursor -drive format=qcow2,file=disk.qcow2

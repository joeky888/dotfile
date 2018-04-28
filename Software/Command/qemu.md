Install qemu on Windows
=====
* $ scoop install qemu

Install debian arm iso (Failed!!)
=====
* See [wiki](https://wiki.qemu.org/Documentation/Platforms/ARM)
* Download debian arm64 iso
* Download vmlinuz and initrd.gz from [debian](http://ftp.debian.org/debian/dists/unstable/main/installer-armhf/current/images/netboot/)
* $ qemu-img create -f qcow2 disk.qcow2 10G
* $ qemu-system-aarch64 -m 1024M -sd disk.qcow2 -M vexpress-a9 -show-cursor -cdrom debian-arm64-DVD-1.iso -kernel vmlinuz -initrd initrd.gz
* $ qemu-system-aarch64 -m 1024M -show-cursor -drive format=qcow2,file=disk.qcow2

Use raspbian (No network!!)
=====
* Download raspbian [](http://downloads.raspberrypi.org/raspbian_lite/images)
* Download raspbian kernel [](https://github.com/dhruvvyas90/qemu-rpi-kernel)
* raspbian and raspbian kernel version should be matched
* $ qemu-system-aarch64 -cpu arm1176 -m 256 -M versatilepb -sd .\raspbian-lite.img -kernel .\kernel-qemu

ReactOS
=====
* Download ReactOS iso
* $ qemu-img create -f qcow2 ReactOS.qcow2 10G
* $ qemu-system-i386 -m 1024M -boot c -cdrom ReactOS.iso -hda ReactOS.qcow2 -localtime -net nic,model=e1000 -net user -serial file:ReactOS.log

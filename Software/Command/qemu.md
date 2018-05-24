Useful params
=====
* Multiple core -smp
    * CPU為一，各CPU核心個數為一，各核心線程數為一，即各CPU總線程數為一
    * $ qemu -smp 1,cores=1,threads=1,sockets=1
    * CPU為二，各CPU核心個數為一，各核心線程數為一，即各CPU總線程數為二
    * $ qemu -smp 2,cores=1,threads=1,sockets=2
    * CPU為四，各CPU核心個數為二，各核心線程數為二，即各CPU總線程數為四
    * $ qemu -smp 16,cores=2,threads=2,sockets=4
* Enable Intel HAXM acceleration
* $ qemu -accel hax
* Enable KVM acceleration, Linux only
* $ qemu -enable-kvm

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
```sh
qemu-img create -f qcow2 ReactOS.qcow2 10G
qemu-system-i386 -m 1024M -boot c -cdrom ReactOS.iso -hda ReactOS.qcow2 -localtime -net "nic,model=ne2k_pci" -net user -serial file:ReactOS.log
```

Resize a disk file
=====
* Download gparted.iso
```sh
qemu-img resize disk.qcow2 +10G
qemu-system-i386 -m 1024M -boot c -cdrom gparted.iso -hda disk.qcow2
```
* Enter to gparted GUI menu -> Partition -> Check
* Disk size will be resized after checking finished

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
* List all CPUs
* $ qemu-system-aarch64 -machine help
* SSH port from host 2222
* $ qemu -redir tcp:2222::22

Install qemu on Windows
=====
* $ scoop install qemu

Install debian arm iso (Failed!!)
=====
* See [wiki](https://wiki.qemu.org/Documentation/Platforms/ARM)
* Don't Download debian daily arm64 iso
* Download vmlinuz and initrd.gz from [debian](http://ftp.debian.org/debian/dists/Debian9.5/main/installer-arm64/current/images/netboot/debian-installer/arm64/)
* Get all CPUs from [wiki](https://wiki.qemu.org/Documentation/Platforms/ARM)
```sh
qemu-img create -f qcow2 debian.qcow2 20G
#qemu-system-aarch64 -m 1024M -hda disk.qcow2 -M vexpress-a9 -show-cursor -cdrom debian-arm64-DVD-1.iso -kernel vmlinuz -initrd initrd.gz -net nic -net user
qemu-system-aarch64 -smp 2 -M virt -cpu cortex-a57 -m 1G \
    -initrd ./initrd.gz \
    -kernel ./linux -append "root=/dev/ram console=ttyAMA0" \
    -global virtio-blk-device.scsi=off \
    -device virtio-scsi-device,id=scsi \
    -drive file=debian.qcow2,id=rootimg,cache=unsafe,if=none \
    -device scsi-hd,drive=rootimg \
    -netdev user,id=unet -device virtio-net-device,netdev=unet \
    -net user \
    -nographic

#qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -smp 1 -m 1024M -kernel ./linux -initrd ./initrd.gz -drive file=debian-arm64.qcow2,id=rootimg,cache=unsafe,if=none -append "root=/dev/ram console=ttyAMA0" -global virtio-blk-device.scsi=off -device virtio-scsi-device,id=scsi -device scsi-hd,drive=rootimg -netdev user,id=unet -device virtio-net-device,netdev=unet -net user
```
* When "[!] Continue without boot loader" shows up, close the vm
* Get initrd and kernel from debian.qcow2
```sh
pkill qemu
sudo powerpill -S nbd # sudo apt install nbd-client
sudo modprobe nbd max_part=8
sudo qemu-nbd --connect=/dev/nbd0 debian.qcow2
mkdir mnt
sudo mount /dev/nbd0p1 mnt
#cp mnt/initrd.img-4.9.0-4-arm64 mnt/vmlinuz-4.9.0-4-arm64 .
cp ./mnt/initrd.img-* ./mnt/vmlinuz-* .
sync
sudo umount /dev/nbd0p1
sudo nbd-client -d /dev/nbd0
```
* Final run
```sh
qemu-system-aarch64 -smp 2 -M virt -cpu cortex-a57 -m 1G \
    -initrd initrd.img-4.9.0-7-arm64 \
    -kernel vmlinuz-4.9.0-7-arm64 \
    -append "root=/dev/sda2 console=ttyAMA0" \
    -global virtio-blk-device.scsi=off \
    -device virtio-scsi-device,id=scsi \
    -drive file=debian.qcow2,id=rootimg,cache=unsafe,if=none \
    -device scsi-hd,drive=rootimg \
    -device e1000,netdev=net0 \
    -net nic \
    -netdev user,hostfwd=tcp:127.0.0.1:2222-:22,,id=net0 \
    -nographic
```
<!-- * $ qemu-system-aarch64 -m 1024M -show-cursor -drive format=qcow2,file=disk.qcow2 -->

Use raspbian (No network!!)
=====
* Download raspbian [](http://downloads.raspberrypi.org/raspbian_lite/images)
* Download raspbian kernel [](https://github.com/dhruvvyas90/qemu-rpi-kernel)
* raspbian and raspbian kernel version should be matched
* $ qemu-system-aarch64 -cpu arm1176 -m 1024M -M versatilepb -sd .\raspbian-lite.img -kernel .\kernel-qemu

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

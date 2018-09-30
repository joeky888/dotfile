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

Enable KVM
=====
```sh
LC_ALL=C lscpu | grep Virtualization # If it output someting means hardware is usable
zgrep CONFIG_KVM /proc/config.gz # You should see CONFIG_KVM_INTEL or CONFIG_KVM_AMD as ‘m’ or ‘y’

sudo powerpill -S virt-manager qemu-arch-extra vde2 ebtables dnsmasq bridge-utils openbsd-netcat --needed
sudo systemctl enable libvirtd.service
sudo systemctl restart libvirtd.service
```

Install qemu on Windows
=====
* $ scoop install qemu

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

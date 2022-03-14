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
* OpenGL acceleration, configuare --enable-sdl
* $ -display sdl,gl=on
* List all CPUs
* $ qemu-system-aarch64 -machine help
* SSH port from host 2222
* $ PORT=22222 qemu -net nic -net user,hostfwd=tcp::${PORT}-:22,hostfwd=tcp::22280-:80

Enable KVM
=====
```sh
LC_ALL=C lscpu | grep Virtualization # If it outputs someting means hardware is usable
zgrep CONFIG_KVM /proc/config.gz # You should see CONFIG_KVM_INTEL or CONFIG_KVM_AMD as ‘m’ or ‘y’

app-fast -S virt-manager qemu-arch-extra vde2 ebtables dnsmasq bridge-utils openbsd-netcat --needed
sudo usermod -aG libvirt $(whoami)
sudo systemctl start --now libvirtd.service
```

Enable GPU passthrough (After KVM is enabled) ...FAILED
=====
* Disable nouveau
    * $ sudoedit /etc/modprobe.d/blacklist-nouveau.conf
* Uninstall all nvidia drivers (pacman -Ss nvidia)
    * Uninstall all bumblebee drivers (pacman -Ss bumblebee)
    * Uninstall all cuda drivers (pacman -Ss cuda)
    * Now `lspci -nnk` should print nvidia driver is "vfio-pci"
```conf
blacklist nouveau
options nouveau modeset=0
```
* Enable iommu (add `intel_iommu=on`)
```sh
sudoedit /etc/default/grub && sudo update-grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_iommu=on" # Use intel_iommu=on for intel
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amd_iommu=on" # Use amd_iommu=on for amd
```
* Get PCI ID of NVIDIA
    * $ lspci -nn | grep -i nvidia
```sh
# If it shows
01:00.0 3D controller [0302]: NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile] [10de:1c8d] (rev ff)
02:00.1 Audio device [0403]: NVIDIA Corporation GP104 High Definition Audio Controller [10de:10f0] (rev a1)
# Which means ID is 10de:1c8d and 10de:10f0

sudoedit /etc/modprobe.d/vfio.conf # Add the following
options vfio-pci ids=01:00.0,02:00.1

sudoedit /etc/modules-load.d/vfio-pci.conf # Add the following
vfio-pci

sudo update-initramfs -u
```
* Install OVMF for UEFT booting
    * $ app-fast -S ovmf
    * $ sudoedit /etc/libvirt/qemu.conf
```conf
nvram = [
    "/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"
]
```
* Boot Windows
```sh
qemu-img create -f qcow2 windows.img 100G

qemu-system-x86_64 \
    -enable-kvm -cpu host \
    -m 2G \
    -net nic,model=rtl8139 \
    -device intel-hda -device hda-duplex \
    --bios /usr/share/ovmf/x64/OVMF_CODE.fd \
    -device vfio-pci,host=01:00.0 `#Add pci id here` \
    -hda windows.img \
    -cdrom WindowsX64.iso
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

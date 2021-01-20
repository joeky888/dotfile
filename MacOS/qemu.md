Install qemu and kvm (Failed)
=====
* Don't do it, use `qemu -accel hvf` instead
* $ app-fast install qemu libvirt
* $ brew services start libvirt
* Rerestart macOS
* $ brew services list

HVF
=====
* Use `qemu -accel hvf`
* Note that
    * Manjaro ISOs are NOT working
    * debian-netinst.iso is working
    * Windows XP iso is workding
* $ app-fast install qemu
```sh
#!/bin/bash

qemu-img create -f qcow2 windows.img 30G

qemu-system-x86_64 \
    -accel hvf -cpu host \
    -m 3G -netdev user,id=n0 -device rtl8139,netdev=n0 \
    -device intel-hda -device hda-duplex \
    -hda windows.img \
    -cdrom windows.iso
```

HVF with OVMF bios
=====
* Qemu use seabios by default, which is unable to boot all Manjaro ISOs
* Download OVMF.fd from Internet
```sh
#!/bin/bash

qemu-img create -f qcow2 manjaro.img 30G

qemu-system-x86_64 \
    -accel hvf -cpu host \
    -smp 1 \ # due to macOS qemu bug, should be fixed soon
    -m 3G -netdev user,id=n0 -device rtl8139,netdev=n0 \
    -device intel-hda -device hda-duplex \
    --bios OVMF.fd \
    -hda manjaro.img \
    -cdrom manjaro.iso
```
* In the Boot menu
    * Highlight line "driver=free" and press E
    * Change "driver=free" to "driver=intel"
    * Highlight line "Boot" and press E
    * Change "driver=free" to "driver=intel"

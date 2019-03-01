Install qemu and kvm (Failed)
=====
* Don't do it, use `qemu -accel hvf` instead
* $ app-fast install qemu libvirt
* $ brew services start libvirt
* Rerestart macOS
* $ brew services list

HVF (TODO)
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
    -m 2G -netdev user,id=n0 -device rtl8139,netdev=n0 \
    -soundhw hda \
    -hda windows.img \
    -cdrom windows.iso
```

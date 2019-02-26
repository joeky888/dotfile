Install qemu and kvm (Failed)
=====
* Don't do it, use `qemu -accel hvf` instead
* $ app-fast install qemu libvirt
* $ brew services start libvirt
* Rerestart macOS
* $ brew services list

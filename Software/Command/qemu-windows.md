Install without kvm
=====
* Download latest iso
```sh
qemu-img create -f qcow2 windows.img 30G

qemu-system-x86_64 \
    -m 2G \
    -net user \
    -net nic,model=rtl8139 \
    -device intel-hda -device hda-duplex \
    -hda windows.img \
    -cdrom WindowsX64.iso
```
* Start
```sh
export VM_SSH_PORT=22222
export VM_EXTRA_PORT=12345
qemu-system-x86_64 \
    -m 2G \
    -net nic,model=rtl8139 \
    -device intel-hda -device hda-duplex \
    -hda windows.img \
    -net user,hostfwd=tcp::${VM_SSH_PORT}-:22,hostfwd=tcp::${VM_EXTRA_PORT}-:${VM_EXTRA_PORT}
```

Install with kvm
=====
* Download latest iso
```sh
qemu-img create -f qcow2 windows.img 30G

qemu-system-x86_64 \
    -enable-kvm -cpu host \
    -m 2G \
    -net user \
    -net nic,model=rtl8139 \
    -device intel-hda -device hda-duplex \
    -hda windows.img \
    -cdrom WindowsX64.iso
```
* Start
```sh
export VM_SSH_PORT=22222
export VM_EXTRA_PORT=12345
qemu-system-x86_64 \
    -enable-kvm -cpu host \
    -m 2G \
    -net nic,model=rtl8139 \
    -device intel-hda -device hda-duplex \
    -hda windows.img \
    -net user,hostfwd=tcp::${VM_SSH_PORT}-:22,hostfwd=tcp::${VM_EXTRA_PORT}-:${VM_EXTRA_PORT}
```

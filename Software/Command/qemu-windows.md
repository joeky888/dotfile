Install without kvm
=====
* Download latest iso
```sh
qemu-img create -f qcow2 windows.img 30G

qemu-system-x86_64 \
    -m 2G -net nic \
    -net user,hostname=windowsvm \
    -soundhw hda \
    -hda windows.img \
    -cdrom WindowsX64.iso
```
* Start
```sh
export VM_SSH_PORT=22222
export VM_EXTRA_PORT=12345
qemu-system-x86_64 \
    -m 2G -net nic \
    -net user,hostname=windowsvm \
    -soundhw hda \
    -hda windows.img \
    -net user,hostfwd=tcp::${VM_SSH_PORT}-:22 \
    -net user,hostfwd=tcp::${VM_EXTRA_PORT}-:${VM_EXTRA_PORT}
```

Install with kvm
=====
* Download latest iso
```sh
qemu-img create -f qcow2 windows.img 30G

qemu-system-x86_64 \
    -enable-kvm -cpu host \
    -m 2G -netdev user,id=n0 -device rtl8139,netdev=n0 \
    -soundhw hda \
    -hda windows.img \
    -cdrom WindowsX64.iso
```
* Start
```sh
export VM_SSH_PORT=22222
export VM_EXTRA_PORT=12345
qemu-system-x86_64 \
    -enable-kvm -cpu host \
    -m 2G -netdev user,id=n0 -device rtl8139,netdev=n0 \
    -soundhw hda \
    -hda windows.img \
    -redir tcp:${VM_SSH_PORT}::22 \
    -redir tcp:${VM_EXTRA_PORT}::${VM_EXTRA_PORT}
```

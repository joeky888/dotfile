Install
=====
* Download latest iso https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/arm64/iso-cd/
* Download qemu uefi http://snapshots.linaro.org/components/kernel/leg-virt-tianocore-edk2-upstream/latest/QEMU-AARCH64/RELEASE_GCC5/QEMU_EFI.img.gz
```sh
gunzip QEMU_EFI.img.gz
qemu-img create -f qcow2 debian.img 20G
qemu-img create -f qcow2 varstore.img 64M

qemu-system-aarch64 \
    -cpu cortex-a53 -M virt -m 2G -nographic \
    -drive if=pflash,format=raw,file=QEMU_EFI.img \
    -drive if=pflash,file=varstore.img \
    -drive if=virtio,file=debian.img \
    -drive if=virtio,format=raw,file=debian-arm64-netinst.iso
```
* Load CD-ROM drivers from removable media?:   Select No
* Manually select a CD-ROM module and device?: Select Yes
* Module needed for accessing the CD-ROM:      Select none
* Device file for accessing the CD-ROM:        Enter /dev/vdb and press Continue
* Complete the installation, Run
```sh
export VM_SSH_PORT=22222
export VM_EXTRA_PORT=12345
qemu-system-aarch64 \
    -cpu cortex-a53 -M virt -m 2G -nographic \
    -drive if=pflash,format=raw,file=QEMU_EFI.img \
    -drive if=pflash,file=varstore.img \
    -drive if=virtio,file=debian.img \
    -redir tcp:${VM_SSH_PORT}::22 \
    -redir tcp:${VM_EXTRA_PORT}::${VM_EXTRA_PORT}

#On vm
nano /etc/ssh/sshd_config
PermitRootLogin yes # Make root ssh accessible
systemctl restart sshd

# On host
ssh -vvv -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p ${VM_SSH_PORT} root@127.0.0.1
```

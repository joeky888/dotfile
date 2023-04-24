Install Archlinux subsystem
=====
* Enable Linux subsystem and give it 30+GB space, as much as possible
* Ctrl+Alt+T to enter crosh
* Follow the latest instructions with additional commands
* https://fydeos.io/docs/knowledge-base/linux-subsystem/archlinux/
* https://fydeos.com/docs/knowledge-base/linux-subsystem/archlinux/
```sh
nano /etc/pacman.conf # Add ParallelDownloads = 16 and add arch cn
########
[options]
Color
ParallelDownloads = 8

[archlinuxcn]
SigLevel = Never
Server = https://cdn.repo.archlinuxcn.org/$arch
########
pacman -Sy pacman-contrib reflector rsync
reflector -a 10 -c cn,jp,sg -f 10 -p https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy archlinuxcn-keyring yay bash-completion

```

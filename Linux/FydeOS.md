Install spark app store (星火應用商店)
=====
* This is maintained by deepin community
* This seems to not support archlinux yet

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

Install snapd and flatpak (debian)
=====
```sh
sudo apt update && sudo apt full-upgrade -y
sudo apt install libsquashfuse0 squashfuse fuse snapd flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
* Reboot FydeOS
* Note that sudo is required for installing any flathub apps


Install chromebrew (Not recommended)
=====
* Ctrl Shift T
```sh
shell # Enter chronos shell
curl https://raw.githubusercontent.com/skycocker/chromebrew/master/install.sh | bash
```

Change resolution for crostini apps
=====
* Settings -> Device -> Displays -> Set Display size to 1280x720

Enable flags (Do this after archlinux is installed!)
=====
* chrome://flags/#crostini-gpu-support -> Check
* Reboot


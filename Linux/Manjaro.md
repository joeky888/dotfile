Install without desktop
=====
* Login as manjaro/manjaro
* $ nmtui # Or edit file directly, see ~/dotfile/Linux/NoX.md
* $ setup

Pre-install
=====
* Windows
  * Use `dd` mode when burn into the USB drive with rufus
* Unix
  * $ sudo fdisk -l
  * $ sudo dd bs=4M if=/path/to/manjaro.iso of=/dev/sd[drive letter] status=progress
  * e.g. /dev/sdb
* When enter to the grub menu, select non-free driver
* Press `E` to edit boot option
  * Add boot option `systemd.mask=mhwd-live.service` to the first line
* Enter boot
* Before starting the GUI installation
  * $ sudo nano /usr/lib/calamares/modules/mhwdcfg/main.py
```python
Change:
def run(self):
  for b in self.bus:
  for id in self.identifier['net']:
  self.configure(b, id)
  for id in self.identifier['video']:
  self.configure(b, id)
  return None

To:
def run(self):
  return None
```
* Now start GUI installation

Install
=====
* Format 300MB fat32 to "/boot/efi"
  * Flag "bootable"
  * Flag "esp"
* Format the rest to ext4

Pacman
=====
* Upgrade packages
    * $ sudo app-fast -Syyu ; sudo pacman -Rsc $(pacman -Qdtq)
* Download only
    * $ pacman -Sw package
    * $ /var/cache/pacman/pkg # Find the package
* Upgrade all AUR packages
    * $ yay -Syyu --aur
* Clear all cache
    * $ sudo pacman -Scc

Use aria2 as backend of pacman
=====
* pacman -S mingw64/mingw-w64-x86\_64-aria2
* Edit /etc/pacman.conf
* XferCommand = aria2c -c -s16 -k1M -x16 --dir=/ -o %o %u

CN packages like baidu pan
=====
* sudoedit /etc/pacman.conf
```dosini
[archlinuxcn]
SigLevel = Never
Server = https://cdn.repo.archlinuxcn.org/$arch
```
```sh
sudo pacman -Syy && sudo app-fast -S --noconfirm --needed archlinuxcn-keyring
sudo app-fast -S --noconfirm --needed teamviewer skypeforlinux-stable-bin ttf-wps-fonts wps-office ttf-iosevka-term ttf-iosevka
```

Unstable and testing package (Manjaro)
=====
* $ sudo pacman-mirrors --api --set-branch testing # Or unstable
* $ sudo pacman-mirrors -f 0

Mhwd
=====
* $ mhwd -l # list all available driver
* Install a driver
* $ mhwd -i pci video-nvidia
* Remove a driver
* $ mhwd -r pci video-nvidia
* $ sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.back
* $ sudo touch /etc/X11/xorg.conf

Mhwd Nvidia on laptop
=====
* From `https://gist.github.com/mauri870/5a54e415140875b9150ca31c491811f6`
* $ sudo mhwd -a pci nonfree 0300 # Or sudo mhwd -i pci video-hybrid-intel-nvidia-bumblebee
* $ sudoedit /etc/default/grub
```conf
GRUB_CMDLINE_LINUX_DEFAULT="acpi_osi=! acpi_osi=\"Windows 2009\""
```
* $ sudo update-grub
* $ sudo gpasswd -a $(whoami) bumblebee
* $ sudo reboot
* $ optirun blender && optirun google-chrome-stable

Install fbterm (recommand)
=====
* $ yay -S fbterm-git
* $ sudo chmod u-s $(which fbterm)
* $ sudo usermod -a -G video $(whoami)
* $ sudo app-fast -S gpm libx86
* $ sudo systemctl enable gpm

Install qemu
=====
* $ sudo app-fast -S qemu-arch-extra

Install virtualbox
=====
* $ uname -a # Get kernel version
* $ sudo app-fast -S virtualbox
* $ sudo app-fast -S [kernel version]-virtualbox-host-modules
* $ sudo modprobe vboxdrv
* $ sudo gpasswd -a $(whoami) vboxusers

No Network interface in NetworkManager
=====
* Remove Network driver in MHWD

Use AUR in docker container
=====
* Use this script https://github.com/greyltc/docker-archlinux-aur

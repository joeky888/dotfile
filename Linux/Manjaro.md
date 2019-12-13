Install without desktop
=====
* Login as manjaro/manjaro
* $ nmtui # Or edit file directly, see ~/dotfile/Linux/NoX.md
* $ sudo pacman-mirrors --use-async -f 0
* $ setup
* Partitions
  * BIOS (Virtualbox)
    * Use fdisk for partitions, use dos
    * m # Show all commands
    * o # Create dos disk label
    * n # New partition
    * a # Add a bootable flag
    * p # Print partitions
    * w # Write
    * q # Quit
  * UEFI (Failed, TODO)
    * Use fdisk for partitions, use gpt
    * m # Show all commands
    * g # Create gpt disk label
    * n -> Enter "2048" ~ "500000" # New partition
    * p # Print partitions
    * t -> Use "1" (EFI System) # Change type
    * x # Expert mode
    * A # Add bootable flag
    * r # return normal mode
    * n -> Format reset to Linux Filesystem # New partition
    * p # Print partitions
    * w # Write
    * q # Quit
    * Format sda2 to ext4
    * Format sda1 to vfat f32 -> mount to "/boot/efi"
<!-- * Don't use pacman-mirrors, it will take a lot of time -->
* Don't refresh keys, it will take a lot of time
* Don't install yay and base-devel, it will take a lot of time
* Install networkmanager
* Set root password and add an user
* $ sudo systemctl enable --now NetworkManager

Pre-install
=====
* Windows
  * Use `dd` mode when burn into the USB drive with rufus
* Unix
  * $ sudo fdisk -l
  * $ sudo dd bs=4M if=/path/to/manjaro.iso of=/dev/sd[drive letter] status=progress
  * e.g. /dev/sdb
* When enter to the grub menu, highlight line "Boot" and press E to edit
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
    * $ app-fast -Syyu ; sudo pacman -Rsuc $(pacman -Qdtq)
* Download only
    * $ pacman -Sw package
    * $ /var/cache/pacman/pkg # Find the package
* Upgrade all AUR packages
    * $ yay -Syyu --aur
* Clear all cache
    * $ sudo pacman -Scc

CN packages like baidu pan
=====
* sudoedit /etc/pacman.conf
```dosini
[archlinuxcn]
SigLevel = Never
Server = https://cdn.repo.archlinuxcn.org/$arch
```
```sh
app-fast -Syy --noconfirm --needed archlinuxcn-keyring
app-fast -S teamviewer skypeforlinux-stable-bin ttf-wps-fonts wps-office ttf-iosevka-term ttf-iosevka
```

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
* $ app-fast -S gpm libx86
* $ sudo systemctl enable gpm && sudo systemctl restart gpm
* $ yay -S fbterm-git
* $ sudo chmod u-s $(which fbterm)
* $ sudo usermod -aG video $(whoami)

Install qemu
=====
* $ app-fast -S qemu-arch-extra

Install virtualbox
=====
* $ uname -a # Get kernel version
* $ app-fast -S virtualbox
* $ app-fast -S [kernel version]-virtualbox-host-modules
* $ sudo modprobe vboxdrv
* $ sudo gpasswd -a $(whoami) vboxusers

Install snapd
=====
```sh
app-fast -S snapd
#sudo systemctl enable --now apparmor.service
#sudo systemctl enable --now snapd.apparmor.service
sudo systemctl enable --now snapd.socket

app-fast -S linux-apparmor # Install/Boot only if systemctl status apparmor.service is failed
```

No Network interface in NetworkManager
=====
* Remove Network driver in MHWD

Remote controll Windows OS
=====
* $ app-fast -S remmina freerdp
* $ killall remmina


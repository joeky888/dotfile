Install without desktop
=====
* Login as manjaro/manjaro
* $ nmtui # Or edit file directly, see ~/dotfile/Linux/NoX.md
* $ sudo pacman-mirrors -f 0 # --use-async
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

Switch to other branches
=====
* sudo pacman-mirrors --api --set-branch stable
* sudo pacman-mirrors --api --set-branch testing
* sudo pacman-mirrors --api --set-branch unstable
* sudo pacman-mirrors -f 0 && app-fast -Syyu

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

Mhwd Nvidia on laptop (bumblebee)
=====
* From `https://gist.github.com/mauri870/5a54e415140875b9150ca31c491811f6`
* bumblebee
  * $ sudo mhwd -a pci nonfree 0300 # Or sudo mhwd -i pci video-hybrid-intel-nvidia-bumblebee
* prime
  * $ sudo mhwd -a pci nonfree 0300 # Or sudo mhwd -i pci video-hybrid-intel-nvidia-prime
* $ sudoedit /etc/default/grub
```conf
GRUB_CMDLINE_LINUX_DEFAULT="acpi_osi=! acpi_osi=\"Windows 2009\""
```
* $ sudo update-grub
* $ sudo gpasswd -a $(whoami) bumblebee
* $ sudo reboot
* bumblebee
  * $ optirun blender && optirun google-chrome-stable
* prime
   $ prime-run blender && prime-run google-chrome-stable

Install fbterm (recommand)
=====
* $ app-fast -S gpm libx86
* $ sudo systemctl enable --now gpm
* $ cd /tmp && git clone --depth 1 https://github.com/ccapitalK/fbterm && cd fbterm
* $ configure && make && sudo make install
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

Downgrade a package
=====
* $ `DOWNGRADE_FROM_ALA=1 downgrade PackageName`
* Undo downgrading
  * Remove "IgnorePkg=xxx" and "IgnoreGroup=xxx" in /etc/pacman.conf
  * $ app-fast -S PackageName # Reinstall PackageName

No Network interface in NetworkManager
=====
* Remove Network driver in MHWD

Remote control Windows OS
=====
* $ sudo snap install remmina
* Or
* $ app-fast -S remmina freerdp
* $ killall remmina

Krita crashed on startup
=====
* $ firejail --noprofile --blacklist=/usr/lib/qt/plugins/platforms/libdxcb.so krita

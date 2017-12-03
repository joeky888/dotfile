Install Fbterm
=====
* $ sudo apt-fast install fbterm fontconfig -y
* $ sudo apt-fast install virtualbox-guest-dkms -y # for virtualbox
* $ sudo fc-cache -fv
* $ fc-list # Check font is installed or not
* $ sudo chmod u-s $(which fbterm) # If try to use fbterm hotkeys, use "u+s" instead
* $ sudo usermod -a -G video $(whoami)
* Reboot OS, when it shows boot menu, type "c" switch to grub mode
* $ grub> vbeinfo
* Pick one from stdout, ex: 1024x768x16
* $ grub> reboot
* $ sudoedit /etc/default/grub && sudo update-grub && sudo update-grub2
```conf
# In this order
GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"
GRUB_CMDLINE_LINUX=""
GRUB_GFXMODE=1024x768x16
GRUB_GFXPAYLOAD_LINUX=1024x768x16
```
* $ sudo reboot

Mouse without x
=====
* Make sure fbterm is installed and functional
* $ sudo apt-fast install gpm
* $ sudo reboot
* Left mouse click is Copy
* Right mouse click is Paste
* If mouse is not available in vim
    * $ vim --version | grep gpm # Check vim gpm support
    * :set mouse=a
    * :set ttymouse=xterm

Mount a USB drive
=====
* $ lsblk
* $ sudo blkid
* $ sudo fdisk -l
* $ sudo mkdir /media/usb
* $ sudo mount /dev/sdb1 /media/usb
* $ sudo umount /media/usb

Change timezone
=====
* $ timedatectl list-timezones | grep Asi
* $ sudo timedatectl set-timezone Asia/Taipei

Listen to music without x
=====
* $ sudo apt-fast install alsa alsa-tools vlc-nox -y
* $ sudo usermod -a -G audio $(whoami)
* $ sudo reboot
* $ alsamixer # Adjust volume
* $ vlc -I ncurses --random ~/Music/\*.mp3
* If there is no sound in virtualbox, switch the audio card in virtualbox setting

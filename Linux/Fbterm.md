Install
=====
* $ sudo apt-fast install fbterm fontconfig -y
* $ sudo apt-fast install virtualbox-guest-dkms -y # for virtualbox
* $ sudo fc-cache -fv
* $ fc-list # Check font is installed or not
* $ sudo chmod u-s $(which fbterm) # If try to use fbterm hotkeys, use "u+s" instead
* $ sudo usermod -a -G video $(whoami)
* $ sudo reboot

Change tty resolution
=====
* $ sudo apt-fast install virtualbox-guest-dkms -y
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

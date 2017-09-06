A good Android phone
=====
* Supported by Lineage OS
* Support OTG
* Support large size external card
* Waterproof

刷機 (flash a new rom)
=====
* 先unlock
* 刷第三方recovery,刷不了先root再刷一次
* 備份系統到 sd 避免出錯
* 將 zip 裡面的 recovery 資料夾刪除，重新壓成 .zip
* 將 zip 放到 sd
* 進入 recovery 刷入 zip

Flash a new rom by PC
=====
* Install adb and fastboot on PC
* unlock the phone
* fastboot oem rebootRUU
* fastboot flash zip xxx.zip

磚機救援 (Recover a Bricked Android Phone)
=====
* Install adb and fastboot on PC
* Download system.img boot.img recovery.img from internet
* system.img can alse be created by using TWRP backup
    * Backup a partition called "System image"
    * In the /sdcard/twrp/backup somewhere can find a file "system\_image.emmc.win"
    * "system\_image.emmc.win" == "system.img"
    * Don't rename it to "system.img"
* Boot phone to TWRP, wipe DalvikCache / System / Data / Internal Storage / Cache
* Boot phone to bootloader
* Open cmd.exe and enter the following commands
    * fastboot oem rebootRUU (if failed, use fastboot reboot-bootloader)
    * fastboot erase system  (if failed ignore it)
    * fastboot erase cache   (if failed ignore it)
    * fastboot flash system system.img (OR fastboot flash system system\_image.emmc.win)
    * fastboot flash boot boot.img
    * fastboot flash recovery recovery.img (OR fastboot flash recovery TWRP.img)
    * fastboot reboot-bootloader

Backup .img files without pc
=====
* Open any terminal emulator on Android
```sh
dd if=/dev/block/mmcblk0p7 of=/sdcard/backups/boot.img
dd if=/dev/block/mmcblk0p15 of=/sdcard/backups/cache.img
dd if=/dev/block/mmcblk0p11 of=/sdcard/backups/logo.bin
dd if=/dev/block/mmcblk0p2 of=/sdcard/backups/nvram.img
dd if=/dev/block/mmcblk0p8 of=/sdcard/backups/recovery.img
dd if=/dev/block/mmcblk0p14 of=/sdcard/backups/system.img
dd if=/dev/block/mmcblk0p16 of=/sdcard/backups/userdata.img
```

ADB
=====
* Connecting from pc to phone
    * adb kill-server
    * adb devices
    * Copy the serial number of the output
* Install .apk to phone
    * Put xxx.apk to same folder with cmd.exe
    * adb -s SerialNumberOfPhone install -r xxx.apk

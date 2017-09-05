A good Android phone
=====
* Supported by Lineage OS
* Support OTG
* Support large size external card
* Waterproof

刷機 (flash a new rom)
=====
* 先unlock或root或兩個都做
* 刷第三方recovery
* 備份系統到 sd 避免出錯
* 將 zip 裡面的 recovery 資料夾刪除，重新壓成 .zip
* 將 zip 放到 sd
* 進入 recovery 刷入 zip

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

ADB
=====
* Connecting from pc to phone
    * adb kill-server
    * adb devices
    * Copy the serial number of the output
* Install .apk to phone
    * Put xxx.apk to same folder with cmd.exe
    * adb -s SerialNumberOfPhone install -r xxx.apk

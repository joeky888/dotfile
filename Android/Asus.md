Flash a new rom
=====
* Download the unlock tool from ASUS download center
* $ adb install xxx.apk # Failed if it's already unlocked
* $ adb reboot recovery
* Boot to bootloader from recovery
* $ fastboot flash recovery ./twrp.img
× $ fastboot reboot

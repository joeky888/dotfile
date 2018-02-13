Flash a new rom
=====
* Download the unlock tool from ASUS download center
* $ adb install unlocked.apk # Failed if it's already unlocked
* $ adb reboot recovery
* Boot to bootloader from recovery
* $ fastboot flash recovery ./twrp.img
* $ fastboot reboot
* $ adb reboot recovery
* Make sure the img SKU is matched to the system SKU (TW -> TW, WW -> WW, JP -> JP)
* Use twrp to backup before flashing anything

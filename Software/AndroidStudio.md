Make build faster
=====
* File -> Settings -> Build, Execution, Deployment -> Build Tools -> Gradle -> Global Gradle settings -> Offline work -> Check
* Edit gradle.properties file, add
```conf
org.gradle.daemon=true
org.gradle.parallel=true
```
* Disable proxy if downloading dependencies takes forever

Android X86 on virtualbox
=====
* Setting -> Developer options -> Stay awake -> Check
* Power off
    * Press Right Ctrl + H
* Install Flashify or FlashFire from Google Play for flash roms

Android Studio + Virtualbox with adb
=====
* Install a Android X86 VM in virtualbox
* Open virtualbox
    * File -> Host Network Manager -> Create a new one
        * Adapter:
            * IPv4 address: 192.168.56.1
            * IPv4 Network Mask: 255.255.255.0
        * DHCP server:
            * Enable server: checked
            * Server Address: 192.168.56.100
            * Server Mask: 255.255.255.0
            * Lower Address Bound: 192.168.56.101
            * Upper Address Bound: 192.168.56.254
    * Machine -> Settings -> Network
        * Adapter 1 -> "Host-Only Adapter" -> type "PCnet-FAST III"
        * Adapter 2 -> "NAT" -> type "PCnet-FAST III"
    * Start VM to get IP -> Settings -> About phone/tablet -> Status -> IP should be 192.168.56.101:5555
* Open terminal in Android Studio -> Console -> /home/joeky/Android/Sdk/platform-tools/adb connect 192.168.56.101
* Run app -> Select "Innotek GmbH VirtualBox" -> Done

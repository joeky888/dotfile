Settings
=====
* Completion -> Case sensitive completion -> None

Keymapping
=====
* File -> Settings -> Keymap -> Editor Actions
    * Delete Line -> Right Click -> Add Keyboard Shortcut -> Ctrl K
    * Replace -> Right Click -> Add Keyboard Shortcut -> Ctrl H
    * Select All -> Right Click -> Add Keyboard Shortcut -> Ctrl G
    * Select Line at Caret -> Right Click -> Add Keyboard Shortcut -> Ctrl L
    * Move Caret to Line Start -> Right Click -> Add Keyboard Shortcut -> Ctrl A
    * Move Caret to Line End -> Right Click -> Add Keyboard Shortcut -> Ctrl E
    * Close -> Right Click -> Add Keyboard Shortcut -> Ctrl W
    * Redo -> Right Click -> Add Keyboard Shortcut -> Ctrl Y
    * Column Selection Mode -> Right Click -> Add Keyboard Shortcut -> Ctrl Q
    * Move Line Up -> Right Click -> Add Keyboard Shortcut -> Pageup
    * Move Line Down -> Right Click -> Add Keyboard Shortcut -> Pagedown
    * Comment with Line Comment -> Right Click -> Add Keyboard Shortcut -> Ctrl \

Colored logcat
=====
* Preferences –> Editor –> Colors & Fonts –> Android Logcat
```conf
Material design palette (Weak):
    Assert : E040FB
    Debug  : 64B5F6
    Error  : EF5350
    Info   : 66BB6A
    Verbose: BBBBBB
    Warn   : FFC107

Material design palette (Strong):
    Assert : 9C27B0
    Debug  : 2196F3
    Error  : F44336
    Info   : 4CAF50
    Warning: FFC107

Darcula palette:
    Assert : 9876AA
    Debug  : 6897BB
    Error  : FF6B68
    Info   : 6A8759
    Verbose: BBBBBB
    Warn   : BBB529
```

Make build faster
=====
* File -> Settings -> Build, Execution, Deployment -> Build Tools -> Gradle -> Global Gradle settings -> Offline work -> Check
* Edit gradle.properties file, add
```conf
org.gradle.daemon=true
org.gradle.parallel=true
```
* Disable proxy if downloading dependencies takes forever

Debug WebView with Chrome
=====
* Set mWebView.setWebContentsDebuggingEnabled(true);
* Enable developer option on Android device
* Connect Android device with USB
* Navigate to the webview area in the Android APP
* Open chrome://inspect in browser

Android X86 on virtualbox
=====
* Setting -> Developer options -> Stay awake -> Check
* Setting -> Developer options -> Drawing ->
    * set Window Animation Scale, Transition Animation Scale, and Animator Duration Scale to OFF
* Power off
    * Press Right Ctrl + H
* Install Flashify or FlashFire from Google Play for flash roms

Android Studio + Virtualbox with adb
=====
* Make sure the virtualbox is installed with the Network option
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

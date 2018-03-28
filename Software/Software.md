Software
=====
* XnView MP
* sogou pinyin/zhuyin
* Opera Developer
* Chrome Developer
* Firefox Developer `https://www.mozilla.org/en-US/firefox/developer/all/`
* Adobe Flash Player Beta
* Wireshark
* Nmap / Zenmap
* Teamviewer
* Baidu Pan(BaiduExporter/百度网盘直接下载助手增强版)
* UNetbootin
* deepin-boot-maker
* Gimp
* Inkscape
* Blender
* Makehuman
* Sweet home 3D
* ngPlant
* Fritzing
* FontForge
* gVim x64
* Brackets
* Visual Studio Code Insiders
* VLC
* Natron
* OBS MP
* Aegisub
* Kdenlive
* Audacity
* LMMS
* Qt
* qTox
* PyCharm Community Edition
* Cheat Engine
* WPS Office (Hong Kong)
* Libre Office
* GSView
* Nomacs
* Popcorn Time
* GeoGebra
* Virtualbox
* TigerVNC
* Sikuli / SikuliX
* Zulu
* JComicDownloader
* JDownloader

CLI
=====
* Miniconda
* BusyBox / Toybox
* Neofetch
* youtube-dl
* you-get / Lulu
* ykdl
* glances
* danmaku2ass (m13253)
* TestDisk / PhotoRec
* FFmpeg
* OpenCC
* Aria2
* Google-drive-ocamlfuse
* Docker

Dev
=====
* Godot
* Android Studio
* Qt Creator
* Eclipse

Windows
=====
* Process Monitor
* build-extra (git for Windows) or msys2
* Cygwin
* Chocolatey
* Greenshot
* Clink
* Rufus
* x64dbg / snowman
* Rainmeter (with Circle-Weather)
* MPC-HC
* Sarasa Mono TC font (for console)
* $ Set-ExecutionPolicy RemoteSigned -Force
* $ Unblock-File $profile
* $ New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name DontUsePowerShellOnWinX -PropertyType DWord –Value 0 -force
* $ PowerShellGet\Install-Module posh-git -Scope CurrentUser
* $ choco install 7zip vim-tux.portable git poshgit aria2 miniconda miniconda3 ffmpeg youtube-dl greenshot wps-office-free obs-studio nmap nomacs vlc virtualbox fontforge sumatrapdf.commandline xnviewmp inkscape cmake.portable adb nodejs phantomjs -y --pre
* $ choco install directx vcredist2005 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2015 vcredist2017 vcredist-all -y --pre
* Gaming dlls
    * $ choco install openal physx.legacy msxml6.sp1 gfwlive xna xna31 silverlight dotnet3.5 dotnet4.0 dotnet4.5 -y -pre

Windows XP
=====
* Qupzilla 1.8.9
* Google Chrome 49
* Powershell 2.0
* Gvim
* Notepad++
* Sublime Text 2/3
* 7zip
* Aria2 (static build)
* git 2.10.0
* Powershell 2
* Qt 5.6 (For development, I'm not sure if the apps built with latest Qt still runs on XP)
* Python 2 (Miniconda2)
* Sumatra PDF
* Greenshot
* Yahoo KeyKey
* Sogou input (zhuyin/pinyin)
* WPS office
* VLC

Mac (Hack-intosh)
=====
* iterm2
* Homebrew
* Homebrew Cask
* MacVim / VimR
* Unarchiver

Linux
=====
* Qupzilla
* NetworkManager / nmtui
* shutter
* Conky (with weather)
* alacritty (terminal emulator but it's new, one have to compile it from source)

Android
=====
* Firefox Nightly
    * Stylus + Midnight Surfing Global Dark Style
    * Undo Close for mobile
    * uBlock Origin
    * Privacy Badger
    * Video Background Play Fix
    * h264ify
    * Video Speed Controller
* OpenLauncher
* Clock by Google
* Facebook Messenger
* LINE
* Barcode Scanner ZXing
* Sogou input method
* Hacker's Keyboard
* Termux
* DroidVim
* VLC nightly
* Kodi
* Amaze File Manager
* WPS office
* Starfire 星火直播
* WiFiAnalyzer open source
* IP webcam
* LibreTorrent
* TWRP Recovery
* Magisk / Xposed
* Opengapps (flash it if gapps are not functional)
* F-Droid
    * Newpipe
    * YalpStore
    * Your local weather
* Drop-down menu items
    * Screenshot
    * Flash light
    * Auto rotate

Good Software Design
=====
* Support "Ctrl + T" New Tab
* Support "Alt + Enter / F11" Full Screen
* Customizable hotkeys
* Hotkeys of other similar softwares are included, such as sublime-text has optional vi binding switcher
* Customizable theming (and Font-Family) with json format
* A light theme and a dark theme built-in
* Always use simple English
* Colorful output in the debug console (Logcat), Red -> Error, Yellow -> Warrning
* Host on github if open source, host on Gogs for self-hosting
* Multiple languages other than just English
* Support Private Tabs/Windows
* Cross Platform
* Less dependencies
* Progress bar
* Sci-Fi User interface, such as "Circle SeekBar"
* 4:3 16:9 16:10 18:9 supported
* 4k and 8k resolution supported
* Easily porting to another system
* A reminder sound after a job done (or a process finished)
* GUI but command line is also available for shell scripting
* Human readable configuration files
* Configuration files are all backward compatible
* Configuration files are under $HOME, and easy to find
* Configuration files support variables, system variables and if-else statements
* 100% Extentable code for future use
* Allow to install extensions
* Responsive UI design for all device
* Call external programs/commands
* Current status / Connection status, like (Green)Good, (Red)Bad
* PrintStatus() function and Error log files (in binary if closed-source)
* Auto updater
* Multiple users Co-op
* Rewards/Praising for user's hard work
* Proxy setting
* Import SSL certificates
* Use emojis in git commit message ✅ ❌
* Use date as version number, e.g. Version YYYY.MM.DD.001
* Create a poll with predefined option for asking user experience, not just give them a piece of blank paper
* Testing and short Documentation and Examples in Documentation
* Create a Wikipedia page for it
* Send crash log to server
* Easter eggs
* Mobile
    * Portable between Android and iOS
    * Most operations can be done with only one finger
* Web plugins
    * Make sure it runs on Chrome, Firefox and Firefox Android

Dev Tools
=====
* Mobile and embbed system
    * React Native
    * Qt + Native WebView (with html5 + WebAssembly)
    * Qt + QML
* GUI on desktop
    * Executable size as small as possible, for personal use : QtLite
    * Development time as fast as possible: Electron (FreeBSD is not supported)
    * As powerful as possible: Qt
* Windows / XBOX only
    * Universal Windows Platform (.AppX)
* Web server backend
    * Java Playframework - Full-featured
    * C++ Crow - Very small and fast
* Web frontend: React.js vue.js
* Browser extension: WebExtension API
    * Modify the source of https://github.com/codebicycle/videospeed , which runs both chrome and firefox and firefox on Android
* CLI
    * Pure Python, Python libs written in pure python
    * C and C++, could be built by gcc and mingw
* Linux CLI/Driver
    * Fbterm, modify the source of the Fbterm
* FreeBSD CLI/Driver
    * Yaft, modify the source of the Yaft
* Data
    * Huge and complicated: Json
    * Small or configurations: TOML
* OS, embbed system: FreeBSD

Experience
=====
| Tool                              |  Year        |
| --------------------------------- | ------------ |
| Windows                           |  (2003-)     |
| Ubuntu Linux                      |  (2014-)     |
| Debian Linux                      |  (2016-)     |
| Deepin Linux                      |  (2017-)     |
| FreeBSD                           |  (2017-)     |
| Git                               |  (2014-)     |
| Bash                              |  (2014-)     |
| Zsh                               |  (2015-)     |
| Tmux                              |  (2015-)     |
| Sublime Text                      |  (2014-2015) |
| Adobe Brackets                    |  (2015-2016) |
| Vim                               |  (2016-)     |
| VSCode                            |  (2016-)     |
| Cygwin                            |  (2015-)     |
| Powershell                        |  (2017-)     |
| Qt                                |  (2014-)     |
| MS Office                         |  (2010-2014) |
| Libre Office                      |  (2014-2015) |
| WPS Office                        |  (2015-)     |
| Chrome                            |  (2010-2015) |
| Opera                             |  (2015-)     |
| PinyinIME 拼音中打                |  (2016-)     |

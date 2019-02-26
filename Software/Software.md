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
* Free Download Manager (Open Source, Win+Mac only)
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
* VLC
* MPV player
* Natron
* OBS MP
* Aegisub
* Kdenlive
* Audacity
* LMMS
* Qt
* qTox
* Cheat Engine
* WPS Office (Hong Kong)
* SoftMaker FreeOffice
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
* LanguageTool
* Cutter - reverse engineering framework

CLI
=====
* Miniconda/python
    * youtube-dl
    * you-get
    * ykdl
    * streamlink
    * bypy
    * speedtest-cli
    * glances
    * danmaku2ass (m13253)
    * dbcli - Cli for mysql, sqlite and Postgresql with syntax highlighting
* Go
    * BaiduPCS-Go
    * Micro (text editor)
    * annie - youtube-dl like video downloader
    * hugo - html generator
    * mkcert - Certificates generator
    * kurly - curl clone written in go
    * hey - loadtest tool written in go
    * bombardier - loadtest tool powered by fasthttp
    * gotop - top-like tool
    * ctop - top-like tool for Docker containers
    * syncthing - sync files between 2 PCs
    * grafana - beautiful monitoring tool
    * enry - Get source code filetype distribution of current folder
    * gotty - SSH alternative via browser Webshell $ gotty -w bash
    * bat - cURL/httpie written in Go
    * hget - aria2/axel download accelerator in go
    * rclone - Google drive (and more) client
    * autopprof - Easy-to-use performance profiler
    * go-freelan - freelan-compatible implementation
    * caddy - apache/nginx alternative
* C
    * Shellinabox - SSH alternative via browser Webshell
    * upx - Ultimate Packer executables, `upx --lzma file.exe`
    * hashcat - fatest password cracking tool
* Rust
    * ffsend - send.firefox.com cli client
```sh
# $ go help get
go get -insecure -u -v github.com/iikira/BaiduPCS-Go
BaiduPCS-Go config set -max_parallel 8
BaiduPCS-Go config set -savedir $HOME/Desktop
BaiduPCS-Go config set -cache_size 16384 # 16MB
BaiduPCS-Go config set -max_download_load 5 # 5 Files one time
BaiduPCS-Go config set -appid=309847 # Or 310646 or 266719
BaiduPCS-Go config set -user_agent="Test"
```
* Nodejs
    * gtop
    * vtop
    * loadtest
    * pm2
    * cloc # Programing language usage analyzer
    * git-stats
* BusyBox / Toybox
* Neofetch
* TestDisk / PhotoRec
* FFmpeg
* OpenCC
* Aria2
* Monitorix
* Google-drive-ocamlfuse
* Docker
* Shellcheck
* Hollywood - Hacker tool collection

Dev
=====
* Godot
* Android Studio
* Qt Creator
* Eclipse
* PyCharm Community Edition
* gVim x64
* Brackets
* Visual Studio Code Insiders

Windows
=====
* build-extra (git for Windows) or msys2
* DirectX Repair (Enhanced Edition) DirectX dll 修復工具增強版
* Greenshot
* Clink
* Rufus
* Rainmeter (with Circle-Weather)
* MPC-HC
* All in One Runtimes
* Sarasa Mono TC font (for console)
* OpenJDK
    * Zulu
    * ojdkbuild - Windows only
    * AdoptOpenJDK
* Scoop
    * $ Set-ExecutionPolicy RemoteSigned -Force
    * $ iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    * $ scoop bucket add extras https://github.com/lukesampson/scoop-extras.git
    * $ scoop bucket add dorado https://github.com/h404bi/dorado
    * $ scoop install win32-openssh vim busybox qemu youtube-dl curl aria2 ffmpeg micro adb nmap go upx nodejs phantomjs mpv miniconda2 miniconda3
<!--     * $ scoop bucket add rasa https://github.com/rasa/scoops.git -->
<!--     * $ scoop install noto-fonts # Install noto fonts will take a long time, and annoying dialog will keep showing -->
```sh
# "" means "(Default)" which equals "@"
[Microsoft.Win32.Registry]::SetValue("HKEY_CLASSES_ROOT\*\shell\Edit with Gvim\command","","$env:USERPROFILE\scoop\apps\vim\current\gvim.exe -p --remote-tab-silent `"%1`"", [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue("HKEY_CLASSES_ROOT\Applications\gvim.exe\shell\open\command","","$env:USERPROFILE\scoop\apps\vim\current\gvim.exe -p --remote-tab-silent `"%1`"", [Microsoft.Win32.RegistryValueKind]::String)
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\\Desktop\\mpv.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\\scoop\\apps\\mpv\\current\\mpv.exe"
$Shortcut.Save()
```
* Chocolatey
    * $ Set-ExecutionPolicy RemoteSigned -Force
    * $ Unblock-File $profile.CurrentUserAllHosts
    * $ New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name DontUsePowerShellOnWinX -PropertyType DWord –Value 0 -force
    * $ PowerShellGet\Install-Module posh-git -Scope CurrentUser
    * $ PowerShellGet\Install-Module posh-docker -Scope CurrentUser
    * $ PowerShellGet\Install-Module windows-screenfetch -Scope CurrentUser
    * $ choco install 7zip git poshgit vscode greenshot wps-office-free obs-studio nomacs fontforge sumatrapdf.commandline xnviewmp inkscape -y --pre
    * $ choco install directx vcredist2005 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2015 vcredist2017 vcredist-all -y --pre
    * Gaming dlls
        * $ choco install openal physx.legacy msxml6.sp1 gfwlive xna xna31 silverlight dotnet3.5 dotnet4.0 dotnet4.5 -y -pre

Windows XP
=====
* Maxthon (傲遊瀏覽器)
    * Ad block plus
    * Stylish
* Google Chrome 49
* Firefox 52
* Free Download Manager 3.9.7
* Powershell 2.0
* BusyBox
* DirectX Repair (Enhanced Edition) DirectX dll 修復工具增強版
* Microsoft .NET Framework Repair Tool
* Microsoft .NET Framework Cleanup Tool
* Gvim
* Micro (text editor written in go)
* Notepad++
* Sublime Text 2/3
* 7zip
* Aria2 (static build)
* git 2.10.0
* Qt 5.6 (For development, I'm not sure if the apps built with latest Qt still runs on XP)
* Python 2 (Miniconda 2 Latest, Anaconda 2 Latest)
* Python 3.4.3 (Miniconda 3 Latest, Anaconda 3 v2.3)
* Sumatra PDF
* Greenshot
* Rime input method
* Yahoo KeyKey
* Sogou input (zhuyin/pinyin)
* WPS office
* VLC
* MPV player 2015-10-29
* FFmpeg 3.x
* PhotoScape 3.7
* Google Picasa

Mac (Hack-intosh)
=====
* Alacritty
* Hyper
* iTerm2 and iTerm2-Color-Schemes
* Dr. Unarchiver
* Homebrew and Homebrew Cask
    * MacVim / VimR
    * Free Download Manager
* WPS Office
* Squirrel
* Spectacle (Window manager)

Linux
=====
* NetworkManager / nmtui
* Shutter
* Conky (with weather)
* Linuxbrew (package manager without root)

WineHQ
=====
* Busybox
* DirectX Repair Tool (Enhanced Edition)
* 7zip

Android
=====
* Firefox Beta
    * Stylus + Midnight Surfing Global Dark Style
    * Undo Close for mobile
    * uBlock Origin
    * Privacy Badger
    * Video Background Play Fix
    * h264ify
    * Video Speed Controller
    * User Agent Switcher (by Alexander Schlarb)
    * Absolute Enable Right Click & Copy
* Opera browser beta
* Clock by Google
* Gmail
* Facebook Messenger
* LINE
* Skype
* Sogou input method / Trime(同文)
* Hacker's Keyboard
* Termux (terminal for Android 5+)
* Pydroid 3 (terminal for Android 4.4+, adb push aria2c /data/data/ru.iiec.pydroid3/files/ )
* DroidVim
* VLC
* mpv-android
* Here WeGo
* Amaze File Manager
* WPS office
* Starfire 星火直播
* WiFiAnalyzer open source
* Advanced Download Manager
* TWRP Recovery
* Magisk / Xposed
* Opengapps (flash it if gapps are not functional)
* APKPure - Google Play alternative
* Qemu Limbo
* SystemPanel 2
* tw.gov.invoice
* F-Droid
    * OpenLauncher
    * MaterialOS Icon Pack
    * Firefox Klar (5.0+) / Fennec (4.1+)
    * Barcode Scanner ZXing
    * Newpipe
    * YalpStore
    * Your local weather
    * Open Camera
    * Busybox
    * LibreTorrent
    * ScreenCam
    * Simple Gallery
* Drop-down menu items
    * Screenshot
    * Flash light
    * Auto rotate
* Not on Google/F-droid
    * Alpha VNC (beta) (No root, Android 5.0+)
    * Entware-ng (root, Termux alternative, Android 4.2.2+)
    * 豌豆荚 wandoujia
    * 應用寶
    * 迅雷

iOS
=====
* Cydia
    * NewTerm 2

Gaming
=====
* Mumu - Android emulator
* RetroArch - Console emulator
    * RetroPie
* Freelan - virual local network/vpn

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
* Host on github if open source, host on Gogs/Gitea for self-hosting
* i18n, Multiple languages other than just English
* Support Private Tabs/Windows
* Cross Platform
* Less dependencies
* Progress bar
* Built-in shell
* TUI/GUI dashboard and resource monitor
    * Google image "大數據可視化"
    * PointDownload
* Sci-Fi User interface, such as "Circle SeekBar"
* Smooth scrolling
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
* A Class of dialog can be easily called and override the method after yes/no clicked
* Allow to install extensions
* Deploy with docker swarm
* Responsive UI design for all device
* Call external programs/commands
* Current status / Connection status, like (Green)Good, (Red)Bad
* PrintStatus() function and Error log files (in binary if closed-source)
* Log files are available in plan-text, html and markdown format
* Stripped binary (like gcc -s)
* Auto updater
* Multiple users Co-op
* Rewards/Praising for user's hard work
* Proxy setting
* Embbed RPC server
* Import SSL certificates
* Use emojis in git commit message ✔️  ❌
* Use date as version number, e.g. Version YYYY.MM.DD.001
* Create a poll with predefined option for asking user experience, not just give them a piece of blank paper
* Testing and short Documentation and Examples in Documentation
* Create a Wikipedia/Wikia page for it
* Community-driven Wikipedia-like site for handling errors
* Send crash log to server
* Feedback button in-app
* Easter eggs
* Software-level Factory reset
* Mobile
    * Portable between Android and iOS
    * Most operations can be done with only one finger
    * Make small button can be easily clicked (bind clicked event with clickable layout surrounding it)
* Web plugins
    * Make sure it runs on Chrome, Firefox and Firefox Android

Dev Tools
=====
* Good IDE:
    * Support performance analyzer (Profiler)
* Mobile and embbed system
    * ReactXP: React + React Native
    * Qt + Native WebView (with html5 + WebAssembly)
    * Qt + QML
* Desktop app
    * Nuklear - Single header opengl-based GUI lib, for C and Go
    * Proton-native, react native syntax and builds native apps (Using libui)
    * libui, native UI and small bianry size, for C/C++ and Go
    * Executable size as small as possible, for personal use :
        * QtLite
        * github.com/zserge/webview - C/C++/Go backend, html fronend
        * github.com/zserge/lorca - Pure Go backend, html fronend
    * Development time as fast as possible: Electron (FreeBSD is not supported)
    * As powerful as possible: Qt
    * go-flutter-desktop-embedder - Flutter Engine in Go
* Windows / XBOX only
    * Universal Windows Platform (.AppX)
* Web server backend
    * Golang
    * Java Playframework - Full-featured
    * C++ Crow - Very small and fast
* Web frontend: React.js, Vue.js, Qt for WebAssembly
* Browser extension: WebExtension API
    * Install mozilla/web-ext
    * Modify the source of https://github.com/codebicycle/videospeed , which runs both chrome and firefox and firefox on Android
* CLI
    * Pure Python, Python libs written in pure python
    * Micropython, pure python lib
    * Go, static compile by default (single executable file) and easily cross-compile to other platforms
    * C and C++, could be built by gcc, mingw and Clang
* Linux CLI/Driver
    * Fbterm, modify the source of the Fbterm
* FreeBSD CLI/Driver
    * Yaft, modify the source of the Yaft
* Data
    * Huge and complicated: Json
    * Small or configurations: TOML
* OS, embbed system: Alpine Linux, FreeBSD

Experience
=====
| Tool                              |  Year         |
| --------------------------------- | ------------- |
| Windows                           |  (2003-)      |
| Ubuntu Linux                      |  (2014-)      |
| Debian Linux                      |  (2016-)      |
| Deepin Linux                      |  (2017-)      |
| Manjaro Linux                     |  (2018-)      |
| Alpine Linux                      |  (2018-)      |
| FreeBSD                           |  (2017-)      |
| macOS                             |  (2019-)      |
| Docker                            |  (2018-)      |
| Git                               |  (2014-)      |
| Bash                              |  (2014-)      |
| Zsh                               |  (2015-)      |
| Fish                              |  (2018)       |
| Tmux                              |  (2015-)      |
| Docker                            |  (2016-)      |
| Youtube-dl                        |  (2015-)      |
| You-get                           |  (2016-)      |
| FFmpeg                            |  (2015-)      |
| Qemu                              |  (2017-)      |
| Sublime Text                      |  (2014-2015)  |
| Adobe Brackets                    |  (2015-2016)  |
| Vim                               |  (2016-)      |
| VSCode                            |  (2016-)      |
| PyCharm                           |  (2018-)      |
| Cygwin                            |  (2015-)      |
| Msys2/Git-SDK                     |  (2016-)      |
| Powershell                        |  (2017-)      |
| Qt                                |  (2014-2016)  |
| React Native                      |  (2018-)      |
| MS Office                         |  (2010-2014)  |
| Libre Office                      |  (2014-2015)  |
| WPS Office                        |  (2015-)      |
| Chrome                            |  (2010-2015)  |
| Opera                             |  (2015-)      |
| ZhuyinIME 注音中打                |  (2003-2016)  |
| PinyinIME 拼音中打                |  (2016-)      |

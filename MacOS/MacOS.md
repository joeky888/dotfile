Make Ctrl key work
=====
* System Settings -> Keyboard -> Keyboard Shortcuts -> Mission Control -> Uncheck "^←" "^↑" "^→" "^↓"
* Command + Option + D -> Hide dock

Post-installed
=====
* System Settings -> Network -> Wi-FI -> Advanced -> DNS -> + ->
```
1.1.1.1
8.8.4.4
180.76.76.76
8.8.8.8
114.114.114.114
```
* System Settings -> Dock -> Automatically hide and show the Dock -> Check
* System Settings -> Battery -> Low Power Mode -> Only on Battery
* System Settings -> Battery -> Options -> Wake for network access -> Never
* System Settings > Security & Privacy > General > Advanced dialog -> Disable auto-logout
* System Settings > Accessibility > Pointer Control > Trackpad Options > Check "Enable dragging" > three finger drag
* System Settings > Accessibility > Zoom > Use scroll gesture with modifier keys to zoom > Check
* System Settings > Desktop & Dock > Recent documents, applications and servers > None
* System Settings > Displays > Automatically adjust brightness > Uncheck
* System Settings > Bluetooth > Show bluetooth in menu bar
* System Settings > VPN > Show vpn in menu bar
* System Settings > Storage > Empty Trash automatically
* System Settings > Keyboard > Shortcuts > Accessibility > enable "Invert colors" > reassign the shortcut to Cmd+Q
* System Settings > Keyboard >
    * Key Repeat > Set to Fastest
    * Delay Until Repeat > Set to Shortest
* System Settings > General > Default web browser > Firefox
* Finder -> View -> Show View Options -> Show icon preview -> Uncheck -> Use as Defaults
* Enable Mojave dark theme
* $ xcode-select --install
* $ brew install neovim sevenzip go node fnm ripgrep fd erdtree fastfetch onefetch bottom mpv
* $ brew tap homebrew/cask-versions
* $ brew install --cask font-noto-sans-cjk font-twitter-color-emoji font-ubuntu-mono-nerd-font alacritty visual-studio-code iina+ docker telegram-desktop dbeaver-community skype teamviewer the-unarchiver krita adobe-acrobat-reader android-platform-tools balenaetcher microsoft-remote-desktop-beta sogouinput chatgpt
* $ brew update && brew upgrade && brew upgrade --cask --greedy && brew cleanup -s --prune=all && brew doctor

App store
=====
* Messenger
* WPS Office (Login with QQ)

Can not open an app due to "Unkown developer"
=====
* System Settings > Security & Privacy > General > Open Anyway

Nslookup alternative
=====
* By default nslookup won't use ipv6
* $ dig A one.one.one.one # Only prints ipv4
* $ dig AAAA one.one.one.one # Only prints ipv6
* $ host one.one.one.one # Prints ipv4/ipv6

Wifi Troubleshooting
=====
* No network after connecting to wifi (Common issues with M-series generation)
  * If it is a problem with mesh wifi, 1. connect to mesh master, and then 2. go to other mesh slave rooms
  * Wifi -> TCP/IP > Try "Using DHCP with Manual Address" > Enter a random address "192.168.0.xxx"


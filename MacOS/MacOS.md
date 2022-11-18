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
* System Settings > Security & Privacy > General > Advanced dialog -> Disable auto-logout
* System Settings > Accessibility > Pointer Control > Trackpad Options > Check "Enable dragging" > three finger drag
* System Settings > Accessibility > Zoom > Use scroll gesture with modifier keys to zoom > Check
* System Settings > Desktop & Dock > Recent documents, applications and servers > None
* System Settings > Displays > Automatically adjust brightness > Uncheck
* System Settings > Bluetooth > Show bluetooth in menu bar
* System Settings > VPN > Show vpn in menu bar
* System Settings > Keyboard > Shortcuts > Accessibility > enable "Invert colors" > reassign the shortcut to Cmd+Q
* System Settings > Keyboard >
    * Key Repeat > Set to Fastest
    * Delay Until Repeat > Set to Shortest
* System Settings > General > Default web browser > Firefox
* Finder -> View -> Show View Options -> Show icon preview -> Uncheck -> Use as Defaults
* Enable Mojave dark theme
* $ xcode-select --install
* $ brew install sevenzip go node ripgrep fd
* $ brew tap homebrew/cask-fonts && brew install font-iosevka font-noto-sans-cjk font-ubuntu font-ubuntu-mono
* $ brew tap homebrew/cask-versions
* $ brew install --cask alacritty visual-studio-code mpv docker-edge opera-beta google-chrome-dev brave-browser-beta firefox-developer-edition opera-gx telegram-desktop dbeaver-community wpsoffice skype teamviewer the-unarchiver krita adobe-acrobat-reader android-platform-tools balenaetcher microsoft-remote-desktop-beta sogouinput openvpn-connect
* $ brew update && app-fast upgrade && brew upgrade --cask --greedy && brew cleanup -s --prune 0 && brew doctor

Can not open an app due to "Unkown developer"
=====
* System Settings > Security & Privacy > General > Open Anyway

Hyper terminal
=====
* $ hyper i hyperocean
* $ vim ~/.hyper.js
```js
css: `
  .xterm {
    cursor: default;
  }
  `,
fontFamily: 'Iosevka, Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
colors: {
  black:          '#1B1D1E',
  red:            '#E90000',
  green:          '#00AF00',
  yellow:         '#F4BF75',
  blue:           '#00AFFF',
  magenta:        '#AE81FF',
  cyan:           '#A1EFE4',
  white:          '#F8F8F2',
  lightBlack:     '#7E8E91',
  lightRed:       '#F92672',
  lightGreen:     '#A6E22E',
  lightYellow:    '#FFFF00',
  lightBlue:      '#66D9EF',
  lightMagenta:   '#AE81FF',
  lightCyan:      '#A1EFE4',
  lightWhite:     '#F8F8F2'
},
```

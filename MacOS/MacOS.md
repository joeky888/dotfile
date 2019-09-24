Make Ctrl key work
=====
* System Preferences -> Keyboard -> Shortcuts -> Mission Control -> Uncheck "^←" "^↑" "^→" "^↓"
* Command + Option + D -> Hide dock

Post-installed
=====
* System Preferences -> Network -> Wi-FI -> Advanced -> DNS -> + ->
```
8.8.4.4
180.76.76.76
8.8.8.8
114.114.114.114
```
* System Preferences -> Dock -> Automatically hide and show the Dock -> Check
* System Preferences > Security & Privacy > General > Advanced dialog -> Disable auto-logout
* System Preferences > Accessibility > Mouse & Trackpad > Trackpad > Check "Enable dragging" > three finger drag
* System Preferences > Accessibility > Zoom > Use scroll gesture with modifier keys to zoom > Check
* System Preferences > General > Recent Items > None
* System Preferences > Displays > Automatically adjust brightness > Uncheck
* System Preferences > Keyboard > Shortcuts > Accessibility > enable "Invert colors" > reassign the shortcut to Cmd+Q
* System Preferences > Keyboard >
    * Key Repeat > Set to Fastest
    * Delay Until Repeat > Set to Shortest
* System Preferences > General > Default web browser > Firefox
* Finder -> View -> Show View Options -> Show icon preview -> Uncheck -> Use as Defaults
* Enable Mojave dark theme
* $ brew cask install alacritty hammerspoon xnviewmp vimr vscodium mpv phantomjs opera google-chrome firefox-developer-edition flash-ppapi wpsoffice skype teamviewer obs the-unarchiver krita adobe-acrobat-reader android-platform-tools balenaetcher font-iosevka font-ubuntu microsoft-remote-desktop-beta
* $ brew cask install baidunetdisk
* $ brew update && app-fast upgrade && brew cask upgrade --greedy && brew cleanup -s --prune 0 && brew doctor

Can not open an app due to "Unkown developer"
=====
* System Preferences > Security & Privacy > General > Open Anyway

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

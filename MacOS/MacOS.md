Make Ctrl key work
=====
* System Preferences -> Keyboard -> Shortcuts -> Mission Control -> Uncheck "^←" "^↑" "^→" "^↓"
* Command + Option + D -> Hide dock

Post-installed
=====
* System Preferences -> Dock -> Automatically hide and show the Dock -> Check
* System Preferences > Security & Privacy > General > Advanced dialog -> Disable auto-logout
* Enable Mojave dark theme
* $ brew cask install hyper xnviewmp visual-studio-code mpv phantomjs opera google-chrome skype teamviewer obs krita font-iosevka font-ubuntu # spectacle

DNS
=====
* System Preferences -> Network -> Select interface
```resolv
nameserver 8.8.4.4
nameserver 180.76.76.76
nameserver 8.8.8.8
nameserver 114.114.114.114
```

Hyper terminal
=====
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

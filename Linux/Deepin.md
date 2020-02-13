After installed
=====
* Setting -> Power Management -> Disable computer auto sleeping
* Setting -> Power Management -> Disable suspend on lid closed
* Setting -> Account -> auto login
* Setting -> Time and Date -> Auto-Sync
* Setting -> Update -> Update Settings -> Auto-download Updates -> Uncheck
* Desktop right click -> Corner Settings -> set right bottom corner to "Desktop"
* $ sudoedit /etc/apt/sources.list -> Use "unstable"
```debsources
deb https://mirrors.tuna.tsinghua.edu.cn/deepin/ unstable main contrib non-free universe
deb http://mirrors.163.com/deepin/ unstable main contrib non-free universe
deb http://mirrors.shu.edu.cn/deepin/ unstable main contrib non-free universe
deb http://ftp.sjtu.edu.cn/deepin/ unstable main contrib non-free universe
deb http://mirror.bit.edu.cn/deepin/ unstable main contrib non-free universe
deb http://ftp.ubuntu-tw.org/mirror/deepin/ unstable main contrib non-free universe
#deb [by-hash=force] http://packages.deepin.com/deepin/ unstable main contrib non-free universe
```
* Disable suspend when closing laptop lid (Manjaro)
  * $ sudoedit /etc/systemd/logind.conf
```conf
HandleLidSwitch=ignore
```
  * $ sudo systemctl restart systemd-logind


Theme
=====
* Display -> Personalization -> Theme -> Deepin-dark
* Display -> Personalization -> Uncheck Enable window effect
* Keyboard and Language -> Uncheck Caps Lock Prompt
* Terminal theme
    * Click setting button -> Switch theme -> Tango
* Dock theme
    * Right click on the dock -> Mode -> Efficient Mode

Change theme
=====
* $ git clone --depth 1 https://github.com/ParrotSec/parrot-themes ~/parrot
* $ rm -rf ~/.local/share/themes/ARK-Dark && cp -r ~/parrot/themes/ARK-Dark ~/.local/share/themes/ARK-Dark
* Or
* Download https://github.com/ParrotSec/parrot-themes
* Extract themes to ~/.local/share/themes Or /usr/local/themes
* Extract icons to ~/.local/share/icons Or /usr/local/icons
* Select theme from deepin settings
* Or
* Edit theme name in both ~/.gtkrc-2.0 and ~/.config/gtk-3.0/settings.ini

Add dns server
=====
* $ sudoedit /var/run/NetworkManager/resolv.conf
* Or
* $ sudoedit /etc/resolv.conf
* Or
* $ sudoedit /run/resolvconf/resolv.conf
* Or
* $ sudoedit /etc/resolvconf/resolv.conf.d/head
```resolv
nameserver 8.8.4.4
nameserver 180.76.76.76
nameserver 8.8.8.8
nameserver 114.114.114.114
```
* $ sudo resolvconf -u

Add apt-get proxy
=====
* $ sudoedit /etc/apt/apt.conf
```conf
Acquire::http::Proxy "http://username:password@proxy.hinet.net:80";
```

Packages
=====
* Deepin
  * $ app-fast install sogoupinyin adb fastboot krita opera-developer opera-stable noto-fonts ttf-wps-fonts vscode teamviewer skypeforlinux qpdfview evince nomacs obs-studio earlyoom console-setup deepin-graphics-driver-manager deepin-remote-assistance deepin-repair-tools deepin-system-monitor deepin.com.baidu.pan opencc vim-gtk3 file-roller software-properties-gtk baobab gnome-system-monitor gnome-disk-utility -y && sudo apt purge vim foxitreader spotify-client skype -y
  * $ app-fast install tlp -y # For laptop, in case deepin is unable to reboot
  * $ sudo apt purge tlp -y && app-fast install laptop-mode-tools -y # For laptop, in case tlp is not working
* Manjaro
  * $ sudo pacman -Rsuc vim laptop-mode-tools
  * $ app-fast -S tlp # Or laptop-mode-tools
  * $ sudo systemctl enable tlp && sudo systemctl restart tlp
  * $ sudo systemctl enable tlp-sleep && sudo systemctl restart tlp-sleep
  * $ app-fast -S gvim code krita fcitx-gtk2 fcitx-gtk3 fcitx-qt5 fcitx-configtool fcitx-sogoupinyin wqy-zenhei noto-fonts-cjk noto-fonts-extra noto-fonts-emoji deepin-boot-maker deepin-editor android-tools opera opera-ffmpeg-codecs firefox-developer-edition chromium brave-beta pepper-flash nomacs qpdfview file-roller obs-studio evince gnome-disk-utility baobab alacritty gnome-terminal ; sudo pacman -Rsuc --noconfirm xarchiver
  * $ yay -S earlyoom
* $ mkdir -p ~/.config/SogouPY/phrase/ && cat $HOME/dotfile/Software/sogou.ini > ~/.config/SogouPY/phrase/PhraseEdit.txt
* Dowload the LibreOffice.appimage
* $ sudoedit /etc/systemd/system/earlyoom.service # Or
* $ sudoedit /usr/lib/systemd/system/earlyoom.service
```conf
# Use 97% of ram
ExecStart=/usr/bin/earlyoom -m 3
```
* $ sudo systemctl restart earlyoom.service
* $ sudo systemctl daemon-reload
* Setting -> Personalization -> Font -> Standard Font -> Noto Sans CJK TC

Disable Gnome keyring when opening the browser
=====
* $ sudo aptitude install seahorse -y
* $ seahorse

Install Rime Pinyin IME (Manjaro)
=====
* $ app-fast -S fcitx fcitx-rime fcitx-im fcitx-configtool fcitx-configtool
* Goto fcitx settings, add Rime, remove all other IMEs
* $ mkdir -p ~/.config/fcitx/rime/
* $ vim ~/.config/fcitx/rime/default.custom.yaml
```yaml
patch:
  schema_list:
    - schema: luna_pinyin_tw       # 朙月拼音 臺灣正體模式
    - schema: luna_pinyin          # 朙月拼音
#     - schema: luna_pinyin_simp     # 朙月拼音 简化字模式
#     - schema: terra_pinyin         # 地球拼音 dì qiú pīn yīn
#     - schema: bopomofo             # 注音
#     - schema: bopomofo_tw          # 注音 臺灣正體模式
#     - schema: jyutping             # 粵拼
#     - schema: cangjie5             # 倉頡五代
#     - schema: cangjie5_express     # 倉頡 快打模式
#     - schema: quick5               # 速成
#     - schema: wubi86               # 五笔86
#     - schema: wubi_pinyin          # 五笔拼音混合輸入
#     - schema: double_pinyin        # 自然碼雙拼
#     - schema: double_pinyin_mspy   # 微軟雙拼
#     - schema: double_pinyin_abc    # 智能ABC雙拼
#     - schema: double_pinyin_flypy  # 小鶴雙拼
#     - schema: wugniu        # 吳語上海話（新派）
#     - schema: wugniu_lopha  # 吳語上海話（老派）
#     - schema: sampheng      # 中古漢語三拼
#     - schema: zyenpheng     # 中古漢語全拼
#     - schema: ipa_xsampa    # X-SAMPA 國際音標
#     - schema: emoji         # emoji表情
```
* $ git clone --depth 1 https://github.com/rime-aca/dictionaries ~/.dict
* $ `ln -sf ~/.dict/luna_pinyin.dict/*.dict.yaml ~/.config/fcitx/rime/`
* $ `vim ~/.config/fcitx/rime/luna_pinyin_tw.custom.yaml`
```yaml
patch:
  # 載入朙月拼音擴充詞庫
  "translator/dictionary": luna_pinyin.extended
```
* Right click fcitx tray icon -> Scheme list -> 明月拼音(臺灣正體)
* Right click fcitx tray icon -> Restart

Install Zhuyin IM
=====
* $ sudo apt install gcin # or hime
* $ im-config -n gcin
* $ sudo reboot

Nvidia driver
=====
* Don't use bumblebee
* $ deepin-graphics-driver-manager

Install Line
=====
* Install Line Chrome App, don't use wine to do this

Unable to remove dock from toolbar
=====
* Check ~/.local/share/applications and /usr/share/applications
* Remove all empty or temp files

Gnome files (Nautilus) fullscreen to normal screen
=====
* Use dconf-editor to disable Gnome files starting with fullscreen

Multiple desktop
=====
* On desktop -> win+s -> click + to add a new desktop
* shift+win left/right to move current window to a new desktop
* win+left/right to switch between desktops

Opera beta is unable to play mp4
=====
```sh
app-fast -S opera-ffmpeg-codecs
sudo ln -sf /usr/lib/opera/lib_extra/libffmpeg.so /usr/lib/opera-beta/libffmpeg.so
```

Opera/Chrome can not display colored emoji
=====
* Reinstall emoji font
* Refresh cache
```sh
sudo pacman -Rsuc noto-fonts-emoji
app-fast -S noto-fonts-emoji
fc-cache -f -v
```


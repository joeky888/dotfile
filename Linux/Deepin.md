After installed
=====
* Setting -> Personlization -> Dark theme
* Setting -> Power Management -> Disable computer auto sleeping
* Setting -> Power Management -> Disable suspend on lid closed
* Setting -> Touchpad -> Natural scrolling -> Check
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
* Manjaro xfce to deepin
  * $ sudo pacman -Rsuc vim laptop-mode-tools xfce4 xfce4-goodies blueman
  * $ app-fast -Syyu # Must upgrade packages before installing deepin
  * $ app-fast -S deepin deepin-screenshot lightdm && sudo systemctl enable lightdm.service && sudoedit /etc/lightdm/lightdm.conf
```dosini
[Seat:*]
greeter-session=lightdm-deepin-greeter
autologin-user=joeky
user-session=deepin
```
  * $ echo $QT_QPA_PLATFORMTHEME # Should output "deepin"
      * If it doesn't output "deepin"
      * Remove the env setting from
      * /etc/environment
      * ~/.profile
      * ~/.xinitrc
  * $ sudo reboot
  * $ app-fast -S libdbusmenu-glib gconf # Reinstall these packages to make snapd work
  * $ app-fast -S tlp # Or laptop-mode-tools
  * $ sudo systemctl enable --now tlp
  * $ sudo systemctl enable --now tlp-sleep
  * $ kwin_x11 --replace # Switch to deepin window manager
  * $ app-fast -S gvim code krita fcitx5 fcitx5-qt fcitx5-gtk fcitx5-rime fcitx5-chinese-addons kcm-fcitx5 wqy-zenhei noto-fonts-cjk noto-fonts-extra noto-fonts-emoji deepin-boot-maker deepin-editor android-tools firefox-developer-edition chromium brave-beta pepper-flash nomacs qpdfview file-roller obs-studio evince gnome-disk-utility baobab alacritty gnome-terminal ; sudo pacman -Rsuc --noconfirm xarchiver
  * $ yay -S earlyoom
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
* $ app-fast -S fcitx5 fcitx5-qt fcitx5-gtk fcitx5-rime fcitx5-chinese-addons kcm-fcitx5
* $ `vim ~/.pam_environment`
```sh
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```
* $ fcitx5
* Goto fcitx settings, add Rime, remove all other IMEs
* $ mkdir -p ~/.local/share/fcitx5/rime/
* $ vim ~/.local/share/fcitx5/rime/default.custom.yaml
```yaml
patch:
  schema_list:
    - schema: luna_pinyin          # 朙月拼音
    - schema: luna_pinyin_tw       # 朙月拼音 臺灣正體模式
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
* $ wget https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.cn_en.dict.yaml -P ~/.local/share/fcitx5/rime/
* $ wget https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.extended.dict.yaml -P ~/.local/share/fcitx5/rime/
* $ wget https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.hanyu.dict.yaml -P ~/.local/share/fcitx5/rime/
* $ wget https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.poetry.dict.yaml -P ~/.local/share/fcitx5/rime/
* $ ln -sf ~/dotfile/Linux/joeky.dict.yaml ~/.local/share/fcitx5/rime
* $ wget https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.1/zhwiki-20200620.dict.yaml -O ~/.local/share/fcitx5/rime/zhwiki-tmp.dict.yaml
* $ opencc -i ~/.local/share/fcitx5/rime/zhwiki-tmp.dict.yaml -c s2t.json -o ~/.local/share/fcitx5/rime/zhwiki.dict.yaml
* $ vim ~/.local/share/fcitx5/rime/luna_pinyin.extended.dict.yaml # Add import table
```yaml
name: luna_pinyin.extended
version: "2015.12.02"
sort: by_weight
use_preset_vocabulary: true
#此處爲明月拼音擴充詞庫（基本）默認鏈接載入的詞庫，有朙月拼音官方詞庫、明月拼音擴充詞庫（漢語大詞典）、明月拼音擴充詞庫（詩詞）、明月拼音擴充詞庫（含西文的詞彙）。如果不需要加載某个詞庫請將其用「#」註釋掉。
#雙拼不支持 luna_pinyin.cn_en 詞庫，請用戶手動禁用。
import_tables:
  - luna_pinyin
  - luna_pinyin.hanyu
  - luna_pinyin.poetry
  - luna_pinyin.cn_en
  - zhwiki # <- Add this
  - joeky  # <- Add this
```
* $ rm ~/.local/share/fcitx5/rime/zhwiki-tmp.dict.yaml
* $ `vim ~/.local/share/fcitx5/rime/luna_pinyin_tw.custom.yaml`
```yaml
patch:
  # 載入朙月拼音擴充詞庫
  "translator/dictionary": luna_pinyin.extended
```
* $ git clone --depth 1 https://github.com/hosxy/fcitx5-dark-transparent.git ~/.local/share/fcitx5/themes/fcitx5-dark-transparent
* Right click fcitx tray icon -> Configure -> Addons -> Classic User Interface ->
    * Font -> Noto Sans CJK -> Size 14
    * Theme -> fcitx5-dark-transparent
* Right click fcitx tray icon -> Restart
* $ cp /usr/share/applications/fcitx5.desktop ~/.config/autostart/
* $ sudo reboot
* $ duolaameng # 哆啦A夢

Install Zhuyin IM
=====
* $ sudo apt install gcin # or hime
* $ im-config -n gcin
* $ sudo reboot

Nvidia driver
=====
* Don't use bumblebee
* $ deepin-graphics-driver-manager

VPN connection
=====
* $ yay -S libreswan networkmanager-l2tp
* $ sudo systemctl restart NetworkManager
* Add a vpn connection in networkmanager
  * Type: L2TP
  * Gateway: VPN server addr
  * Username: myusername
  * Password: mypassword
  * Enable IPsec -> Set "mykey" to Pre-Shared Key (PSK)
* $ cd /etc/NetworkManager
* $ sudo -s
* $ vim ./system-connections/VPNxxxx.nmconnection
```conf
# Remove these lines
#ipsec-esp=
#ipsec-gateway-id=
#ipsec-group-name=
#ipsec-ike=
```
* $ sudo systemctl restart NetworkManager
* $ nmtui
  * Active a connection -> VPN

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


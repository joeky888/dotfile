Pre install (Manjaro Deepin only)
=====
* Use `dd` mode when burn into the USB drive with rufus
* When enter to the grub menu, select non-free driver
* Press `E` to edit boot option
  * Add boot option `systemd.mask=mhwd-live.service` to the first line
* Enter boot
* Before starting the GUI installation
  * $ sudo nano /usr/lib/calamares/modules/mhwdcfg/main.py
```python
Change:
def run(self):
  for b in self.bus:
  for id in self.identifier['net']:
  self.configure(b, id)
  for id in self.identifier['video']:
  self.configure(b, id)
  return None

To:
def run(self):
  return None
```
* Now start GUI installation

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
deb [by-hash=force] http://ftp.ubuntu-tw.org/mirror/deepin/ unstable main contrib non-free universe
# This one is optional
deb http://ftp.tw.debian.org/debian/ unstable main contrib non-free
```

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
  * $ sudo apt-fast install sogoupinyin adb fastboot opera-developer opera-stable vscode teamviewer skypeforlinux qpdfview evince nomacs vlc obs-studio earlyoom console-setup deepin-graphics-driver-manager deepin-remote-assistance deepin-repair-tools deepin-system-monitor deepin.com.baidu.pan opencc vim-gtk3 file-roller software-properties-gtk baobab gnome-system-monitor gnome-disk-utility -y && sudo apt purge vim foxitreader spotify-client skype -y
  * $ sudo apt-fast install tlp -y # For laptop, in case deepin is unable to reboot
  * $ sudo apt purge tlp -y && sudo apt-fast install laptop-mode-tools -y # For laptop, in case tlp is not working
* Manjaro
  * $ sudo pacman -Rs vim --noconfirm; sudo pacman -Qdtq | pacman -Rs -
  * $ sudo powerpill -S --noconfirm --needed laptop-mode-tools # For laptop, in case deepin is unable to reboot
  * $ sudo powerpill -S --noconfirm --needed gvim fcitx fcitx-rime fcitx-im fcitx-configtool fcitx-configtool android-tools opera opera-ffmpeg-codecs nomacs qpdf file-roller vlc obs-studio evince gnome-disk-utility baobab
  * $ yaourt -S --noconfirm --needed visual-studio-code-bin teamviewer skypeforlinux-stable-bin earlyoom
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

Disable Gnome keyring when opening the browser
=====
* $ sudo aptitude install seahorse -y
* $ seahorse

Install Pinyin IM (Manjaro)
=====
* $ sudo powerpill -S --noconfirm --needed fcitx fcitx-rime fcitx-im fcitx-configtool
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
* Right click fcitx tray icon -> Scheme list -> 明月拼音(臺灣正體)

Install Zhuyin IM
=====
* $ sudo apt install gcin # or hime
* $ im-config -n gcin
* $ sudo reboot

Nvidia driver
=====
* Don't use bumblebee
* $ deepin-graphics-driver-manager

Run Android apk files
=====
* $ sudo apt-fast install archon-integration deepin-archon -y
```sh
AndroidApkRun(){
  apk=$1
  if [ -z $apk ];then
    echo "apk needed."
    exit 1
  fi
  ret=$(/usr/lib/node_modules/chromeos-apk/chromeos-apk --archon -t --scale --name "Android App" "$apk")
  ret=${ret#Directory \" }
  ret=${ret% \" created*}
  /lastore/framework/myarchon/archonrun --silent-launch --load-and-launch-app=$ret
}
```
* $ AndroidApkRun xxx.apk

Install Line
=====
* Install Line Chrome App, don't use wine to do this

Install conky
=====
* $ sudo apt-fast install conky conky-manager -y
* $ conky-manager

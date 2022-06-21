Install without desktop
=====
* Login as manjaro/manjaro
* $ nmtui # Or edit file directly, see ~/dotfile/Linux/NoX.md
* $ sudo pacman-mirrors --api --set-branch stable --continent
* $ setup
* Partitions
  * BIOS (Virtualbox)
    * Use fdisk for partitions, use dos
    * m # Show all commands
    * o # Create dos disk label
    * n # New partition
    * a # Add a bootable flag
    * p # Print partitions
    * w # Write
    * q # Quit
  * UEFI (Failed, TODO)
    * Use fdisk for partitions, use gpt
    * m # Show all commands
    * g # Create gpt disk label
    * n -> Enter "2048" ~ "500000" # New partition
    * p # Print partitions
    * t -> Use "1" (EFI System) # Change type
    * x # Expert mode
    * A # Add bootable flag
    * r # return normal mode
    * n -> Format reset to Linux Filesystem # New partition
    * p # Print partitions
    * w # Write
    * q # Quit
    * Format sda2 to ext4
    * Format sda1 to vfat f32 -> mount to "/boot/efi"
* Don't refresh keys, it will take a lot of time
* Don't install yay and base-devel, it will take a lot of time
* Install networkmanager
* Set root password and add an user
* $ sudo systemctl enable --now NetworkManager

Pre-install
=====
* Windows
  * Use `dd` mode when burn into the USB drive with rufus
* Unix
  * $ sudo fdisk -l
  * $ sudo dd bs=4M if=/path/to/manjaro.iso of=/dev/sd[drive letter] status=progress
  * e.g. /dev/sdb
* When enter to the grub menu, highlight line "Boot" and press E to edit
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

Install
=====
* Format 300MB fat32 to "/boot/efi"
  * Flag "bootable"
  * Flag "esp"
* Format the rest to ext4

Xfce
=====
* Settings ->
  * Appearance ->
    * Style -> Matcha-dark-sea
    * Fonts -> Default Font -> Noto Sans CJK TC Medium
    * Fonts -> Default Monospace Font -> Iosevka Medium
  * Panel ->
    * Appearance ->
      * Dark mode -> Check
      * Adjust size automatically -> Check
    * Items -> Window Buttons -> Double Click ->
      * Show button labels -> Uncheck
      * Sorting order -> None, allow drag-and-drop
  * Workspaces -> Number of workspaces -> 1
  * Power Manager -> System -> When laptop lid is closed -> Switch off display
  * Power Manager -> Display -> Put to sleep after -> Never
  * Power Manager -> Display -> Switch off after -> Never
  * Power Manager -> Security -> Automatically lock the session -> Never
* Window Manager -> Style -> Theme -> Matcha-dark-sea
* LightDM Setting -> Appearance ->
  * Theme -> Matcha-dark-sea
  * Background -> Color -> Black
  * Save
* Manjaro Settings Manager ->
  * Set time and date automatically -> Check
  * Hardware clock in local time zone -> Check
* Manjaro Notifier ->
  * Only notify recommanded kernels -> check
* $ app-fast -S gvim mpv code krita krita-plugin-gmic fcitx5 fcitx5-qt fcitx5-gtk fcitx5-rime fcitx5-chinese-addons kcm-fcitx5 noto-fonts-cjk noto-fonts-extra noto-fonts-emoji android-tools firefox-developer-edition brave-beta nomacs file-roller evince gnome-disk-utility baobab alacritty gnome-terminal


Switch to other branches
=====
* sudo pacman-mirrors --api --set-branch stable --protocols https --continent
* sudo pacman-mirrors --api --set-branch testing --protocols https --continent
* sudo pacman-mirrors --api --set-branch unstable --protocols https --continent
* app-fast -Syyu

Pacman
=====
* Upgrade packages
    * $ app-fast -Syyu; sudo pacman -Rsuc $(pacman -Qdtq)
    * $ sudo pamac update && sudo pamac clean
* Download only
    * $ pacman -Sw package
    * $ /var/cache/pacman/pkg # Find the package
* Upgrade all AUR packages
    * $ yay -Syyu --aur && yay -Scc --noconfirm
* Clear all cache
    * $ sudo pacman -Scc

CN packages like baidu pan
=====
* sudoedit /etc/pacman.conf
```dosini
[options]
Color
ParallelDownloads = 8

[archlinuxcn]
SigLevel = Never
Server = https://cdn.repo.archlinuxcn.org/$arch
```
```sh
app-fast -Syy --noconfirm --needed archlinuxcn-keyring
app-fast -S ttf-wps-fonts ttf-iosevka
```

Mhwd
=====
* $ mhwd -l # list all available driver
* Install a driver
* $ mhwd -i pci video-nvidia
* Remove a driver
* $ mhwd -r pci video-nvidia
* $ sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf.back
* $ sudo touch /etc/X11/xorg.conf

Mhwd Nvidia on laptop (bumblebee)
=====
* From `https://gist.github.com/mauri870/5a54e415140875b9150ca31c491811f6`
* bumblebee
  * $ sudo mhwd -a pci nonfree 0300 # Or sudo mhwd -i pci video-hybrid-intel-nvidia-bumblebee
* prime
  * $ sudo mhwd -a pci nonfree 0300 # Or sudo mhwd -i pci video-hybrid-intel-nvidia-prime
* $ sudoedit /etc/default/grub
```conf
GRUB_CMDLINE_LINUX_DEFAULT="acpi_osi=! acpi_osi=\"Windows 2009\""
```
* $ sudo update-grub
* $ sudo gpasswd -a $(whoami) bumblebee
* $ sudo reboot
* bumblebee
  * $ optirun blender && optirun google-chrome-stable
* prime
  * $ prime-run blender && prime-run google-chrome-stable
  * Or
  * $ DRI_PRIME=1 prime-run blender && DRI_PRIME=1 prime-run google-chrome-stable

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
* $ fcitx5-configtool
* Goto fcitx settings, add Rime, remove all other IMEs
* $ mkdir -p ~/.local/share/fcitx5/rime/
* $ vim ~/.local/share/fcitx5/rime/default.custom.yaml
```yaml
patch:
  schema_list:
#     - schema: luna_pinyin          # 朙月拼音
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
* Download the following files
```sh
aria2c https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.cn_en.dict.yaml -d ~/.local/share/fcitx5/rime/
aria2c https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.extended.dict.yaml -d ~/.local/share/fcitx5/rime/
aria2c https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.hanyu.dict.yaml -d ~/.local/share/fcitx5/rime/
aria2c https://github.com/rime-aca/dictionaries/raw/master/luna_pinyin.dict/luna_pinyin.poetry.dict.yaml -d ~/.local/share/fcitx5/rime/
ln -sf ~/dotfile/Linux/joeky.dict.yaml ~/.local/share/fcitx5/rime
aria2c https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.2/zhwiki-20210120.dict.yaml -d ~/.local/share/fcitx5/rime/ -o zhwiki-tmp.dict.yaml
opencc -i ~/.local/share/fcitx5/rime/zhwiki-tmp.dict.yaml -c s2t.json -o ~/.local/share/fcitx5/rime/zhwiki.dict.yaml
rm ~/.local/share/fcitx5/rime/zhwiki-tmp.dict.yaml
```
* $ vim ~/.local/share/fcitx5/rime/luna_pinyin.extended.dict.yaml # Add import table
```yaml
name: luna_pinyin.extended
version: "2015.12.02"
sort: by_weight
use_preset_vocabulary: true
#此處爲明月拼音擴充詞庫（基本）默認鏈接載入的詞庫，有朙月拼音官方詞庫、明月拼音擴充詞庫（漢語大詞典）、明月拼音擴充詞庫（詩詞）、明月拼音擴充詞庫（含西文的詞彙）。如果不需要加載某个詞庫請將其用「#」註釋掉。
#雙拼不支持 luna_pinyin.cn_en 詞庫，請用戶手動禁用。
import_tables:
  - joeky  # <- Add this
  - zhwiki # <- Add this
  - luna_pinyin
  - luna_pinyin.hanyu
  - luna_pinyin.poetry
  - luna_pinyin.cn_en
```
* $ rm ~/.local/share/fcitx5/rime/zhwiki-tmp.dict.yaml
* $ `vim ~/.local/share/fcitx5/rime/luna_pinyin_tw.custom.yaml`
```yaml
patch:
  # 載入朙月拼音擴充詞庫
  "translator/dictionary": luna_pinyin.extended
```
* $ git clone --depth 1 https://github.com/hosxy/fcitx5-dark-transparent.git ~/.local/share/fcitx5/themes/fcitx5-dark-transparent
* fcitx5-configtool -> Configure -> Addons -> Classic User Interface ->
    * Font -> Noto Sans CJK -> Size 14
    * Theme -> fcitx5-dark-transparent
* Right click fcitx tray icon -> Restart
* $ ln -sf /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart/
* $ sudo reboot
* $ duolaameng # 哆啦A夢

Install fbterm (recommand)
=====
* $ app-fast -S gpm libx86
* $ sudo systemctl enable --now gpm
* $ cd /tmp && git clone --depth 1 https://github.com/ccapitalK/fbterm && cd fbterm
* $ configure && make && sudo make install
* $ sudo chmod u-s $(which fbterm)
* $ sudo usermod -aG video $(whoami)

Install qemu
=====
* $ app-fast -S qemu-system-x86 qemu-desktop

Install virtualbox
=====
* $ uname -a # Get kernel version
* $ app-fast -S virtualbox
* $ app-fast -S [kernel version]-virtualbox-host-modules
* $ sudo modprobe vboxdrv
* $ sudo gpasswd -a $(whoami) vboxusers

Install snapd
=====
```sh
app-fast -S snapd
#sudo systemctl enable --now apparmor.service
#sudo systemctl enable --now snapd.apparmor.service
sudo systemctl enable --now snapd.socket

app-fast -S linux-apparmor # Install/Boot only if systemctl status apparmor.service is failed
```

Downgrade a package
=====
* $ `DOWNGRADE_FROM_ALA=1 downgrade PackageName`
* Undo downgrading
  * Remove "IgnorePkg=xxx" and "IgnoreGroup=xxx" in /etc/pacman.conf
  * $ app-fast -S PackageName # Reinstall PackageName

No Network interface in NetworkManager
=====
* Remove Network driver in MHWD

Remote control Windows OS
=====
* $ sudo snap install remmina
* Or
* $ app-fast -S remmina freerdp
* $ killall remmina

Slow boot time
=====
* $ systemd-analyze
* $ systemd-analyze blame
* $ systemd-analyze critical-chain


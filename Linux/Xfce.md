After installed
=====
* Settings ->
    * Appearance ->
        * Style -> Matcha-dark-azul
        * Fonts -> Default Font -> Noto Sans CJK TC Medium
        * Fonts -> Default Monospace Font -> Iosevka Medium
    * Workspaces -> Number of workspaces -> 1
    * Power Manager -> System -> When laptop lid is closed -> Switch off display
    * Power Manager -> Display -> Put to sleep after -> Never
    * Power Manager -> Display -> Switch off after -> Never
    * Power Manager -> Security -> Automatically lock the session -> Never
* Manjaro Settings Manager ->
    * Set time and date automatically -> Check
    * Hardware clock in local time zone -> Check
* $ app-fast -S gvim mpv code krita krita-plugin-gmic fcitx5 fcitx5-qt fcitx5-gtk fcitx5-rime fcitx5-chinese-addons kcm-fcitx5 noto-fonts-cjk noto-fonts-extra noto-fonts-emoji android-tools firefox-developer-edition brave-beta nomacs file-roller evince gnome-disk-utility baobab alacritty gnome-terminal

Auto login
=====
* $ sudoedit /etc/lightdm/lightdm.conf
```conf
[Seat:*]
greeter-session=lightdm-gtk-greeter
user-session=xfce
session-wrapper=/etc/lightdm/Xsession
autologin-user=joeky # Add this line
```
* $ sudo groupadd -r autologin
* $ sudo gpasswd -a joeky autologin

Install arc theme
=====
* $ git clone --depth 1 https://github.com/ParrotSec/parrot-themes ~/parrot
* $ mkdir -p ~/.themes && cp -r ~/parrot/themes/ARK-Dark ~/.themes/ARK-Dark
* $ mkdir -p ~/.icons && cp -r ~/parrot/icons/Windows-10-Icons ~/.icons/Windows-10-Icons
* $ gtk-update-icon-cache -f -t ~/.icons/Windows-10-Icons
* Or
* Xfce Settings Manager -> Window Manager -> Style -> ARK-Dark
* Xfce Settings Manager -> Appearance -> Style -> ARK-Dark
* Xfce Settings Manager -> Appearance -> Icons -> Windows-10-Icons
* Active alternatives
    * https://github.com/jnsh/arc-theme
    * https://github.com/andreisergiu98/arc-flatabulous-theme

Add new startup program
=====
* Open xfce4-session-settings
    * Application Autostart -> enable the software

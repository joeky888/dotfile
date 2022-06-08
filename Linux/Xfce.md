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

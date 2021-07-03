Softwares
=====
```sh
flatpak install flathub com.wps.Office
flatpak install flathub io.dbeaver.DBeaverCommunity
flatpak install flathub org.kde.krita
flatpak install flathub org.telegram.desktop
flatpak install flathub com.valvesoftware.Steam.CompatibilityTool.Proton
flatpak install flathub com.valvesoftware.Steam.CompatibilityTool.Proton-GE

flatpak install flathub io.mpv.Mpv && sudo flatpak override io.mpv.Mpv --filesystem=xdg-config/mpv:ro # Read mpv.conf

flatpak install flathub-beta com.brave.Browser
```

Install
=====
* $ app-fast -S flatpak
* $ flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo # Add beta repo
* $ flatpak update
* $ flatpak install flathub com.wps.Office

Upgrade all apps
=====
* $ flatpak update

Uninstall an app
======
* $ flatpak uninstall io.mpv.Mpv --delete-data && flatpak uninstall --unused
* $ sudo rm /var/lib/flatpak/overrides/io.mpv.Mpv

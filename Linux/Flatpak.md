Softwares
=====
* com.wps.Office
* io.mpv.Mpv
* io.dbeaver.DBeaverCommunity
* org.kde.krita
* org.telegram.desktop
* com.valvesoftware.Steam.CompatibilityTool.Proton
* com.valvesoftware.Steam.CompatibilityTool.Proton-GE

Install
=====
* $ app-fast -S flatpak
* $ flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo # Add beta repo
* $ flatpak update
* $ flatpak install flathub com.wps.Office
* $ flatpak install flathub io.mpv.Mpv
* $ sudo flatpak override io.mpv.Mpv --filesystem=xdg-config/mpv:ro # Read mpv.conf
* $ flatpak install flathub-beta com.brave.Browser

Upgrade all apps
=====
* $ flatpak update

Uninstall an app
======
* $ flatpak uninstall io.mpv.Mpv --delete-data && flatpak uninstall --unused
* $ sudo rm /var/lib/flatpak/overrides/io.mpv.Mpv

Install
=====
* $ app-fast -S flatpak
* $ flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo # Add beta repo
* $ flatpak update
* $ flatpak install flathub com.wps.Office
* $ flatpak install flathub io.mpv.Mpv
* $ sudo flatpak override io.mpv.Mpv --filesystem=xdg-config/mpv:ro
* $ flatpak install flathub-beta com.brave.Browser

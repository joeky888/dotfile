Softwares
=====
```sh
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub com.wps.Office
flatpak install flathub io.dbeaver.DBeaverCommunity
flatpak install flathub org.kde.krita
flatpak install flathub org.qbittorrent.qBittorrent
flatpak install flathub org.telegram.desktop && sudo flatpak override org.telegram.desktop --filesystem=xdg-desktop
flatpak install flathub com.discordapp.Discord && sudo flatpak override --filesystem=home com.discordapp.Discord
flatpak install flathub com.valvesoftware.Steam.CompatibilityTool.Proton
flatpak install flathub com.valvesoftware.Steam.CompatibilityTool.Proton-GE
flatpak install flathub io.mpv.Mpv && sudo flatpak override io.mpv.Mpv --filesystem=xdg-config/mpv:ro # Read mpv.conf
flatpak install flathub-beta com.brave.Browser

ln -sf /var/lib/flatpak/exports/share/applications/org.telegram.desktop.desktop ~/.config/autostart
ln -sf /var/lib/flatpak/exports/share/applications/com.discordapp.Discord.desktop ~/.config/autostart
```

Install beta packages
=====
* $ app-fast -S flatpak
* $ flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo # Add beta repo
* $ flatpak update -y
* $ flatpak install flathub com.wps.Office

Upgrade all apps
=====
* $ flatpak update -y && flatpak uninstall --unused

Uninstall an app
======
* $ flatpak uninstall io.mpv.Mpv --delete-data && flatpak uninstall --unused
* $ sudo rm /var/lib/flatpak/overrides/io.mpv.Mpv
* Or
* $ sudo flatpak override io.mpv.Mpv --nofilesystem=xdg-config/mpv:ro # Undo overriding

Add program to startup
=====
* $ ln -sf /var/lib/flatpak/exports/share/applications/org.telegram.desktop.desktop ~/.config/autostart/

Install steam and proton
=====
* $ flatpak install flathub com.valvesoftware.Steam
* $ flatpak install flathub-beta com.valvesoftware.Steam.CompatibilityTool.Proton
* $ flatpak install flathub-beta com.valvesoftware.Steam.CompatibilityTool.Proton-GE
* $ flatpak install com.github.Matoking.protontricks
* $ flatpak install flathub-beta com.valvesoftware.Steam.Utility.vkBasalt # Optional, use `ENABLE_VKBASALT=1 %command%` to gain more FPS
* $ flatpak override --user --filesystem=/home/hdd/steam com.valvesoftware.Steam # Optional, set steam download folder to another disk drive
* $ flatpak override --user --filesystem=/home/hdd/steam com.github.Matoking.protontricks # Optional, set steam download folder to another disk drive
* $ WINETRICKS=/path/to/latest/winetricks flatpak run com.github.Matoking.protontricks # Optional winetricks packages
* Relaunch Steam executable
* Steam -> Settings
  * Downloads (Optional)
    * Steam Library Folders -> + -> Add another disk drive
  * Steam Play
    * Enable Steam Play for supported titles -> Check
    * Enable Steam Play for all other titles -> Uncheck
    * And the drop-down menu should show proton and proton-ge runtimes
      * Choose either one
* Steam -> Choose a game on the left
  * Right click -> Properties -> Compatibility -> Force the use of a specific Steam Play compatibility tool -> Check
  * Right click -> Properties -> General -> Launch options ->
    * For nvidia/intel -> `gamemoderun %command%`
    * For nvidia prime (Run like `prime-run`) -> `__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia gamemoderun %command%`
  * Right click -> Install -> Choose a disk to install from the drop-down menu (Optional)
* Game env list
```sh
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia %command% # Run like prime-run %command%
ENABLE_VKBASALT=1 %command% # Enable vkBasalt for better performance
DXVK_HUD=fps # Values can be `full` `1` `devinfo,fps`, show game performance info
```

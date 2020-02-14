Search package
======
* https://snapcraft.io/store

Install softwares
=====
* $ sudo snap install microk8s --beta --classic
* Packages
    * Docker (x64, arm64)
    * microK8s (x64, arm64)
    * helm (x64, arm64)
    * Gnome System Monitor (x64, arm64)
    * NetworkManager (x64, arm64)
    * Remmina (x64, arm64)
    * RetroArch (x64, arm64)
    * Blender
    * WPS Office
    * VLC
    * WoeUSB
    * Skype
    * Krita
    * VScode
    * Slack
    * Opera
    * Opera-beta
    * Chromium
    * Firefox
    * Brave
    * Obs-Studio
    * draw.io
    * Dev tools
        * jq
        * conda
        * node
        * go
        * ubuntu-make
        * google-cloud-sdk
        * Android studio


Upgrade all packages
=====
* $ snap refresh

Services
=====
* List of services
* $ snap services
* Restart a service
* $ snap restart xxx

Clean up old packages
=====
```sh
snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then sudo snap remove "$snapname" --revision="$rev"; fi; done
```

Install docker
=====
```sh
sudo snap install docker --edge # Must use edge version
# sudo groupadd --system docker
# sudo usermod -aG docker $(whoami)
# newgrp docker
```

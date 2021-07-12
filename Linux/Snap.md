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
    * Skype # Doesn't support IME
    * Krita
    * Codium by Snapcrafters (vscode)
    * Slack
    * Opera
    * Opera-beta
    * Chromium
    * Firefox
    * Brave
    * Obs-Studio
    * draw.io
    * Games
        * Veloren (Cubeworld-like game in rust)
    * Dev tools
        * jq
        * conda
        * node
        * go
        * ubuntu-make
        * google-cloud-sdk
        * Android studio
        * devoperator # This include kubectl aws-cli eksctl


Upgrade all packages
=====
* $ snap refresh

Services
=====
* List of services
* $ snap services
* Restart a service
* $ snap restart xxx
* Log a service
* $ snap logs -f xxx

Clean up old packages
=====
```sh
snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then sudo snap remove "$snapname" --revision="$rev"; fi; done
```

Install docker
=====
```sh
sudo snap install docker
# sudo groupadd --system docker
# sudo usermod -aG docker $(whoami)
# newgrp docker
# sudo snap disable docker
# sudo snap enable docker
```

Snap docker error (dial tcp: lookup registry-1.docker.io ... read: connection refused)
=====
* Switch to another snap version
* One of these command should work
```sh
sudo snap refresh docker --edge
sudo snap refresh docker --beta
```

Build snap package locally
=====
```sh
sudo snap install snapcraft --classic
sudo snap install multipass
git clone https://github.com/snapcrafters/codium && cd codium
rm -f *.snap && snapcraft clean && snapcraft --debug
sudo snap install ./codium_1.46.1_amd64.snap --dangerous --devmode
```

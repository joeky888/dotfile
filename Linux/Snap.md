Search package
======
* https://snapcraft.io/store

Install softwares
=====
* $ sudo snap install microk8s --beta --classic
* Packages
    * docker
    * microk8s
    * helm
    * krita
    * remmina
    * blender
    * android-studio
    * obs-studio
    * vscode
    * alacritty
    * chromium
    * firefox
    * brave

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

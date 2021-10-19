Search package
======
* https://snapcraft.io/store

Install softwares
=====
```fish
sudo snap install microk8s --beta --classic
sudo snap install helm --classic
sudo snap install kubectl --classic
sudo snap install opera-beta
sudo snap install auto-cpufreq
sudo auto-cpufreq --install # sudo snap services
sudo snap install docker
sudo snap disable docker && sudo snap enable docker
# sudo groupadd --system docker
# sudo usermod -aG docker $(whoami)
# newgrp docker
# sudo snap disable docker
# sudo snap enable docker
```
* Packages
  * Gnome System Monitor (x64, arm64)
  * NetworkManager (x64, arm64)
  * WoeUSB
  * Dev tools
    * Android studio
    * devoperator # including kubectl aws-cli eksctl


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

Build snap package locally
=====
```sh
sudo snap install snapcraft --classic
sudo snap install multipass
git clone https://github.com/snapcrafters/codium && cd codium
rm -f *.snap && snapcraft clean && snapcraft --debug
sudo snap install ./codium_1.46.1_amd64.snap --dangerous --devmode
```

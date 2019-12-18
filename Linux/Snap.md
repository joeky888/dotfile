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

Upgrade all packages
=====
* $ snap refresh

Services
=====
* List of services
* $ snap services
* Restart a service
* $ snap restart xxx

Install docker
=====
```sh
sudo snap install docker --edge # Must use edge version
# sudo groupadd --system docker
# sudo usermod -aG docker $(whoami)
# newgrp docker
```

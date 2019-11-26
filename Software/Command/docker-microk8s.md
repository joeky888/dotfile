Archlinux microK8s (native, Linux only, minimal ram 2G)
=====
```sh
sudo snap install docker --edge # If docker is not installed
# sudo groupadd --system docker
# sudo usermod -aG docker $(whoami)
# newgrp docker

sudo snap install microk8s --edge --classic
sudo usermod -aG microk8s $(whoami)
sudo snap install helm --edge --classic

sudo iptables -P FORWARD ACCEPT
sudo ufw allow in on cbr0 && sudo ufw allow out on cbr0

# Enable ingress so there is no need to install metallb and ingress controller
# It will create a namespace ingress but we don't have to install our cluster into this namespace
microk8s.enable dns storage helm ingress
microk8s.status
microk8s.inspect

rm -rf ~/.helm
KUBECONFIG=/snap/microk8s/current/microk8s-resources/client.config helm init

# Get kubectl-apiserver token and cert
microk8s.kubectl get secret
microk8s.kubectl get secret default-token-xxxxx -o yaml

# Uninstall
microk8s.disable storage
microk8s.reset
sudo snap remove microk8s helm
```

Remote control via token
=====
```sh
# Get kubect-apiserver
Edit /snap/microk8s/current/microk8s-resources/default-args/kube-apiserver
Or /snap/microk8s/current/microk8s-resources/default-args/kube-apiserver
And set the --insecure-bind-address=127.0.0.1 to 0.0.0.0
microk8s.stop && microk8s.start


```


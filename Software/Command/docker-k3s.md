Archlinux k3s (native, Linux only)
=====
```sh
mkdir -p k3s && cd k3s
curl -LO https://github.com/k3s-io/k3s/raw/master/docker-compose.yml # Or
wget https://github.com/k3s-io/k3s/raw/master/docker-compose.yml

vim docker-compose.yml
    Add restart: always
    Update image tags to latest
openssl rand -base64 45 > k3s.token
K3S_TOKEN="$(cat k3s.token)" docker-compose up -d --build

sudo snap install kubectl --classic
kubectl --kubeconfig ./kubeconfig.yaml get node # Or create soft link like this
mkdir -p ~/.kube/
ln -sf $PWD/kubeconfig.yaml ~/.kube/config
kubectl get node

# Uninstall
K3S_TOKEN="$(cat k3s.token)" docker-compose down
rm kubeconfig.yaml
#sudo rm -rf /var/lib/rancher /etc/rancher
rm -rf ~/.kube
docker volume prune
```

Token (TODO: find out what is this)
=====
```sh
# Inside docker container "server"
cat /var/lib/rancher/k3s/server/node-token
```

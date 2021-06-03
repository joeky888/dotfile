Archlinux k3s (native, Linux only)
=====
```sh
mkdir -p k3s && cd k3s
curl -LO https://github.com/k3s-io/k3s/raw/master/docker-compose.yml # Or
wget https://github.com/k3s-io/k3s/raw/master/docker-compose.yml

vim docker-compose.yml
  Add restart: always
  Change image tags to latest stable # The one wihtout rc1 rc2 in image tags
  Add `command: server --tls-san 192.168.1.100 --tls-san 192.168.1.101 --disable traefik` to server # where `192.168.1.xx` are the client ips of the k8s operators
  Add `command: server --kubelet-arg='--eviction-hard=imagefs.available<50%'` # New flag for --image-gc-high-threshold=50%
  Add `80:80` and `443:443` port exporting on the server # For ingress
  Remove the volume at bottom and line `k3s-server:/var/lib/rancher/k3s` # This seems to be useless
  Increase ulimit to both server and agent services like this
    ulimits:
      nproc: 65535
      nofile:
        soft: 65535
        hard: 65535
openssl rand -base64 45 > k3s.token
K3S_TOKEN="$(cat k3s.token)" docker-compose up -d --build

sudo snap install kubectl --classic
sudo snap install helm --classic
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

Remote accessing
=====
```sh
vim ./kubeconfig.yaml # Edit ip from 127.0.0.1 to the real server ip

kubectl --insecure-skip-tls-verify --kubeconfig ./kubeconfig.yaml get node # Or copy kubeconfig file to ~/.kube/config
```

Ingress controller (built-in traefik)
====
* A default traefik ingress controller is already bundled so just test it with ~/dotfile/Dockerfile/k8s/simple-nginx.yaml
* Make sure port 80:80 and 443:443 is configured on docker-compose server side
* Remember to change the `kubernetes.io/ingress.class` to `traefik` instead of `nginx`
* $ curl localhost

Ingress controller (nginx)
=====
* Add `--disable traefik` to the docker-compose server command
  * So it looks like this `command: server --tls-san 192.168.1.100 --disable traefik`
* Make sure port 80:80 and 443:443 is configured on docker-compose server side
* Run docker-compose up again
* Use helm to install nginx controller, and remember to specify the kubeconfig.yaml
  * E.g. `helm --kubeconfig ./kubeconfig.yaml install ingress-nginx ingress-nginx/ingress-nginx`
* Test with `~/dotfile/Dockerfile/k8s/simple-nginx.yaml`
* $ curl localhost

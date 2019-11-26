Archlinux k3s (native, Linux only)
=====
```sh
git clone --depth 1 https://github.com/rancher/k3s
cd k3s
vim docker-compose.yml
    Add network_mode: host to server # Don't add to node
    Add restart: always
    Update image tags to latest
docker-compose up -d

# Download hyperkube from https://github.com/rancher/k3s/releases
# No need to use `sudo`
./hyperkube kubectl --kubeconfig ./kubeconfig.yaml get all --all-namespaces -o wide | grcat ~/.grc/conf.kubectl

# Uninstall
docker rm -f k3s_server_1 k3s_node_1
docker rmi `docker images -q`
rm kubeconfig.yaml
#sudo rm -rf /var/lib/rancher /etc/rancher
rm -rf ~/.kube
docker network prune
docker volume prune
```

Archlinux k8s (TODO)
=====
* Install etcd (optional)
```sh
yay -S etcd-bin
sudo systemctl enable etcd.service
sudo systemctl restart etcd.service
```
* Install kubernetes and helm
```sh
app-fast -S ebtables ethtool socat
yay -S kubernetes-bin
yay -S kubernetes-helm-bin
mkdir -p ~/.kube && cp /etc/kubernetes/config ~/.kube/config && rm -rf ~/.helm

sudo systemctl enable kubelet

sudoedit /usr/llib/systemd/system/docker.service
    Add `--exec-opt native.cgroupdriver=systemd` to the end of ExecStart
sudoedit /etc/kubernetes/kubelet
    KUBELET_ADDRESS="--address=0.0.0.0"
    KUBELET_HOSTNAME=""
    KUBELET_API_SERVER=""
    KUBELET_ARGS="--cgroup-driver=systemd --runtime-cgroups=/systemd/system.slice --kubelet-cgroups=/systemd/system.slice"
sudoedit /etc/kubernetes/apiserver
    KUBE_API_ADDRESS="--insecure-bind-address=0.0.0.0 --insecure-port=8080"
    KUBE_ETCD_SERVERS="--etcd-servers=http://127.0.0.1:2380"
    KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart kubelet
sudo systemctl restart kube-apiserver
systemctl status docker     # Make sure it is not dead
systemctl status kubelet    # Make sure it is not dead
systemctl status kube-apiserver  # Make sure it is not dead
sudo systemctl set-property docker.service MemoryAccounting=yes
sudo systemctl set-property docker.service CPUAccounting=yes
systemctl show docker | grep Accounting
sudo systemctl restart kubelet

sudo kubeadm reset
sudo rm -rf /var/lib/etcd/*
sudo kubeadm init --apiserver-advertise-address=0.0.0.0 --pod-network-cidr=10.254.0.0/16 --ignore-preflight-errors=all --v=7 # Verbose level 7 out of 10

sudo systemctl restart kubelet.service
sudo systemctl restart kube-scheduler.service
sudo systemctl restart kube-apiserver.service

helm init
helm version
```

Minikube
=====
* Install virtualbox, kubectl, minikube and helm
```sh
# docker pull
minikube start --vm-driver=virtualbox
minikube dashboard
```

Uninstall Minikube
=====
```sh
minikube stop; minikube delete
docker stop (docker ps -aq)
rm -r ~/.kube ~/.minikube
sudo rm /usr/local/bin/localkube /usr/local/bin/minikube
systemctl stop '*kubelet*.mount'
sudo rm -rf /etc/kubernetes/
docker system prune -af --volumes
```

Kubectl
=====
```sh
# docker run
kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080

# Get all, like docker ps -a
kubectl get all --all-namespaces -o wide
# docker ps -a deployment from default namespace
kubectl --namespace=default get deployment -o wide
# docker ps -a pod
kubectl --namespace=default get pod -o wide
# docker ps -a service
kubectl --namespace=default get service -o wide

# docker exec -it container /bin/sh
kubectl exec -it podName -- /bin/sh

# docker logs -f container
kubectl logs -f podName

# docker rm and docker stop
kubectl delete deployment hello-minikube
kubectl delete pod hello-minikube-6fd785d459-dmr7x

# docker-compose up -d -f service.yml
kubectl apply -f ./service.yml

# delete all from default namespace
kubectl delete --all all --namespace=default
# delete all pods
kubectl delete --all pods --namespace=default
# deete all deployments
kubectl delete --all deployments --namespace=default
# delete all services
kubectl delete --all services --namespace=default
```

k8s dashboard
=====
* 使用 k8s 內建的 web ui 查看 cluster 狀況
```sh
# 取得 admin 使用者的 token
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin | awk '{print $1}')
kubectl proxy
* 瀏覽器輸入 http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
* 輸入剛剛得到的 token 登入
```


Archlinux k8s
=====
* Install etcd (optional)
```sh
yay -S etcd-bin
sudo systemctl enable etcd.service
sudo systemctl restart etcd.service
```
* Install kubernetes and helm
```sh
yay -S kubernetes-bin
yay -S kubernetes-helm-bin
```

Minikube
=====
* Install virtualbox, kubectl, minikube and helm
```sh
# docker pull
minikube start --vm-driver=virtualbox
minikube dashboard

# docker run
kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080

# docker ps -a deployment
kubectl get deployment -o wide
# docker ps -a pod
kubectl get pod -o wide
# docker ps -a service
kubectl get service -o wide

# docker exec container cat /etc/hostname
kubectl exec podName -- cat /etc/hostname

# docker logs -f container
kubectl logs -f podName

# docker rm and docker stop
kubectl delete deployment hello-minikube
kubectl delete pod hello-minikube-6fd785d459-dmr7x

# Get all nodes
kubectl get node -o wide

# docker-compose up -d -f service.yml
kubectl create -f ./service.yml

# delete all pods
kubectl delete --all pods --namespace=default
# deete all deployments
kubectl delete --all deployments --namespace=default
# delete all services
kubectl delete --all services --namespace=default
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

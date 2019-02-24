Minikube
=====
* Install virtualbox, kubectl and minikube
```sh
# docker pull
minikube start --vm-driver=virtualbox
minikube dashboard

# docker run
kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080

# docker images
kubectl get deployment -o wide

# docker ps -a
kubectl get pod -o wide

# docker exec container cat /etc/hostname
kubectl exec podName -- cat /etc/hostname

# docker logs -f container
kubectl logs -f podName

# docker rm and docker stop
kubectl delete deployment hello-minikube
kubectl delete pod hello-minikube-6fd785d459-dmr7x

# Get all clusters
kubectl get service

# docker-compose up -d -f service.yml
kubectl create -f ./service.yml
```


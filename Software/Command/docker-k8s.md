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


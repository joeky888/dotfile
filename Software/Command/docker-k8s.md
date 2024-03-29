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

Custom ingress 404,500,503 page instead of nginx default backend
=====
* Add these annotations to the target ingress config
```yaml
nginx.ingress.kubernetes.io/default-backend: nginx-errors
nginx.ingress.kubernetes.io/custom-http-errors: "404,500,503"
```
* Apply nginx-errors service and deployment
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-errors
  labels:
    app.kubernetes.io/name: nginx-errors
    app.kubernetes.io/part-of: ingress-nginx
spec:
  selector:
    app.kubernetes.io/name: nginx-errors
    app.kubernetes.io/part-of: ingress-nginx
  ports:
  - port: 80
    targetPort: 8080
    name: http
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-errors
  labels:
    app.kubernetes.io/name: nginx-errors
    app.kubernetes.io/part-of: ingress-nginx
  annotations:
    reloader.stakater.com/auto: "true"
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: nginx-errors
      app.kubernetes.io/part-of: ingress-nginx
  template:
    metadata:
      labels:
        app.kubernetes.io/name: nginx-errors
        app.kubernetes.io/part-of: ingress-nginx
    spec:
      containers:
      - name: nginx-error-server
        image: ghcr.io/181192/custom-error-pages:latest
        ports:
        - containerPort: 8080
        env:
        - name: DEBUG # Enable debug log
          value: "true"
        - name: ERROR_FILES_PATH # theme
          value: "./themes/ghost"
        - name: HIDE_DETAILS
          value: "true"
        - name: LOG_COLOR
          value: "true"
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 1
          timeoutSeconds: 3
          periodSeconds: 5
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 1
          timeoutSeconds: 3
          periodSeconds: 5
```

ingress nginx returns 404 when visiting `/<path>`
=====
* Add this line `try_files $uri $uri/ /index.html;` to frontend nginx dockerfile
* Normally the location of the file is `/etc/nginx/conf.d/default.conf` in docker image
```conf
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        try_files $uri $uri/ /index.html; # <----- Add this line
        index  index.html index.htm;
    }
}
```
* Or try this if it doesn't work
```conf
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    location / {
        if ($request_uri = "/") { # Caching path / 60s in case CDN servers weren't aware of content changing
          add_header 'Cache-Control' "public, max-age=60";
        }
        root   /usr/share/nginx/html;
        try_files $uri $uri/ @router;
        index  index.html index.htm;
    }

    location @router {
        rewrite ^.*$ /index.html last;
    }
}
```

Debug cert-manager
* $ kubectl get challenge -A
* $ kubectl get cert -A
* $ kubectl get ingress -A
* $ kubectl get all -n cert-manager


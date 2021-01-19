Archlinux microK8s (native, Linux only, minimal ram 2G)
=====
```sh
sudo snap install docker --edge # If docker is not installed
# sudo groupadd --system docker
# sudo usermod -aG docker $(whoami)
# newgrp docker

sudo snap install microk8s --edge --classic
sudo usermod -aG microk8s $(whoami)

sudo iptables -P FORWARD ACCEPT
sudo ufw allow in on cbr0 && sudo ufw allow out on cbr0
sudo apt install iptables-persistent -y # Store iptables setting, select "Yes" when installing

# Enable ingress so there is no need to install metallb and ingress controller
# It will create a namespace ingress but we don't have to install our cluster into this namespace
microk8s.enable dns storage helm3 ingress metrics-server
microk8s.status
microk8s.inspect
microk8s.ctr image ls # Like `docker images`
curl 127.0.0.1 # Try this to check ingress load balancer is working or not
Also make sure all ingresses has apiVersion: networking.k8s.io/v1 in version 1.20+


rm -rf ~/.helm
KUBECONFIG=/snap/microk8s/current/microk8s-resources/client.config helm init

vim /var/snap/microk8s/current/args/kube-apiserver # Add `--allow-privileged` && microk8s.stop && microk8s.start

# Get kubectl-apiserver token and cert
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token

# Uninstall
microk8s.disable storage
microk8s.reset
sudo snap remove microk8s helm
```

Ingress not working
=====
* Make sure your 80 and 443 ports are working and are not blocked by a firewall (e.g docker run --rm -p 80:80 nginx && curl `Your_Public_IP`)
* Run microk8s.enable dns ingress
* Make sure your ingress api version is set to apiVersion: networking.k8s.io/v1
* Make sure you have removed this line kubernetes.io/ingress.class: nginx
* Run microk8s.kubectl get ingress -A and make sure `ADDRESS` is set to `127.0.0.1` and is not empty
* Example
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: http-ingress
  annotations:
    # kubernetes.io/ingress.class: nginx # Try to remove this line or maybe set it to "public"
    # cert-manager.io/cluster-issuer: letsencrypt-prod # This is for cert-manager
    # kubernetes.io/tls-acme: "true" # This is for cert-manager
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web
            port:
              number: 80
```

Remote control via token
=====
```sh
# View read-only config file to get port
# /snap/microk8s/current/microk8s-resources/default-args/kube-apiserver
# Or /snap/microk8s/current/microk8s-resources/default-args/kube-apiserver

# Get kubectl-apiserver token and cert
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token

# On remote machine, default apiserver port is 16443
kubectl config set-credentials microk8s-secret --token=ayJhbGciOiJSUzI1NiIsImtpZCI6Ilo5Y3RxN1dGU1diNmtBTHFNNmFSQ1lQR3hzVDZtWVR6NWRzVVV6R2Nsd0kifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tczVjbW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImI5NGE0NjBjLTc2MDgtNDc5OC1hMzY2LTcxMmFiODI3NmNlYiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.KNbZ9sD2sUAzNxwHuPg5QeJLqNXBCO5xwkwM-PXXJXxiZU8-DSPR-RBeCRYROdCiPAIhkxT4QQiS396g6Sc8hXDecsg3hwzL1XyDsby3a4YwXXVlUJyx7XBMQs2mi5Q_3zKWl-GGJTAbNJQZSL81Kzkuf51RpfkC_s5820Vbw5wPQzQ6_g9QeN5q3CEI63eliMs85KJo_53ifCKsUMq1V7buPputwFwp_6BoFYjYN6qvUqDYQGKbCHPJjRQ-jPsd2zKROTP9M691kldGdahqA-uo8c3i3p8GcCY11L0qJ27L3OLrBB9F7Pr3eq6mx4uA_ZEeb5IliepuTPIdWEeKag
kubectl config set-cluster microk8s-cluster --server=https://ec2-18-162-210-00.ap-east-1.compute.amazonaws.com:16443 --certificate-authority=$HOME/.ssh/microk8s.crt
kubectl config set-context microk8s --cluster=microk8s-cluster --user=microk8s-secret
kubectl config use-context microk8s
kubectl --insecure-skip-tls-verify get all --all-namespaces
```

Clear images like `docker rmi $(docker images -q)`
=====
```sh
microk8s.ctr image rm `microk8s.ctr image list | awk {'print $1'}`
```

Install cert-manager
=====
* Must point the dns server (like godaddy and cloudflare) to the cluster first, USE DNS-Only NOT PROXY
* Install cert-manager via helm chart and install it into the "cert-manager" namaspace
* Install a Custom Resource Definitions via kubectl apply
* Add these line to ingress annotations
    * kubernetes.io/ingress.class: nginx
    * kubernetes.io/tls-acme: "true"
    * nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    * cert-manager.io/cluster-issuer: letsencrypt-prod
* Troubleshooting
    * $ microk8s.kubectl get all -n cert-manager
    * $ microk8s.kubectl get crd -n cert-manager
    * $ microk8s.kubectl get challenges -n cert-manager
    * $ microk8s.kubectl get cert -n myapp
    * $ microk8s.kubectl get secret -n myapp
        * In case everything doesn't work, use these settings to disable https for self-signed
            * acme.cert-manager.io/http01-edit-in-place: "true"
            * cert-manager.io/cluster-issuer: letsencrypt-prod
            * cert-manager.io/issue-temporary-certificate: "true"
            * kubernetes.io/ingress.class: nginx # This line should be removed or use the value "public" in version 1.20+
            * kubernetes.io/tls-acme: "true"
            * nginx.ingress.kubernetes.io/ssl-redirect: "false"

Change default dns from 8.8.8.8 to x.x.x.x
=====
```sh
microk8s.kubectl edit -n kube-system cm/coredns
```


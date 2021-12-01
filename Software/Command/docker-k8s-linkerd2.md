Helm Install (OpenSSL version to be continued...)
=====
* Create mTLS private key and public cert for 10y
* Create root-ca With OpenSSL
  * nodes: 不要幫 key 加密
  * keyout: Private root key
  * out:    Public root ca
  * sha256: 用 SHA256 做檢查碼（Digest）
  * newkey rsa:4096: 建立一個新的 4096 bits 的 RSA key
  * x509: 輸出 x509 的 certificate ，而不要輸出 certificate request
  * req: Certificate Request(PKCS #10)
  * sub: C: 2 digits country code; CN: Domain name
```sh
openssl req -x509 -sha256 -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 -days 3650 -subj "/C=US/CN=root.linkerd.cluster.local" -nodes -keyout ca.key -out ca.crt
openssl x509 -noout -text -in ca.crt # Validate
# OR
step certificate create root.linkerd.cluster.local ca.crt ca.key --profile root-ca --no-password --insecure --not-after=87600h
```
* Create intermediate-ca from root-ca
```sh
step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
  --profile intermediate-ca --not-after 87600h --no-password --insecure \
  --ca ca.crt --ca-key ca.key
```
* Helm install
```sh
kubectl create namespace linkerd2 # Chart will be installed into linkerd2, but all components will be installed into linkerd
helm repo add linkerd https://helm.linkerd.io/stable
helm repo update
# No need to create the namespace linkerd, helm will create it
helm upgrade --install linkerd2 \
  --set-file identityTrustAnchorsPEM=ca.crt \
  --set-file identity.issuer.tls.crtPEM=issuer.crt \
  --set-file identity.issuer.tls.keyPEM=issuer.key \
  --set identity.issuer.crtExpiry=$(date -d '+87600 hour' +"%Y-%m-%dT%H:%M:%SZ") \
  linkerd/linkerd2 --debug -n linkerd2

helm upgrade --install linkerd-viz linkerd/linkerd-viz \
		--set podAnnotations."linkerd\.io/inject"=enabled \ # This is a must
		--set podAnnotations."config\.linkerd\.io/admission-webhooks"=disabled \ # Remove this line if the injection is not working
		--debug -n linkerd2

linkerd2 check # Varify
linkerd2 viz check
kubectl get pod -n linkerd-viz # Make sure viz pods are all injected by side-cars
linkerd2 viz dashboard # Start a dashboard (grafana included)
curl -H "Host: localhost" http://localhost:50570 # Only localhost host header is availble
```

Injected to the app
=====
* Inject into a namespace
```yaml
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    linkerd.io/inject: enabled # This is a must
    config.linkerd.io/admission-webhooks: disabled # This is a must
    config.linkerd.io/proxy-await: enabled # Optional
  name: app
```
* Inject into a deployment
```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      annotations:
        linkerd.io/inject: enabled # This is a must
        config.linkerd.io/admission-webhooks: disabled # This is a must
        config.linkerd.io/opaque-ports: 5432,mysql # This is a must
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        command: ["/bin/sh", "-c"]
        args: ["echo 'Hello' > /usr/share/nginx/html/index.html && nginx -g \"daemon off;\""]
        ports:
        - name: service
          containerPort: 80
```

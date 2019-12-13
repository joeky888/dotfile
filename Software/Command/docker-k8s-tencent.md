騰訊雲
=====
* All ingress service should using NordPort
* Add `kubernetes.io/ingress.class: "qcloud"` to ingress

Save kube context
=====
```sh
kubectl cluster-info -s "https://cls-p0jwiqj9.ccs.tencent-cloud.com" --token=VJ7fKLujME66Dut3bNx13xTBAaHg8ffo --certificate-authority=$HOME/.ssh/tke-sdk.crt

kubectl config set-credentials tke-sdk-secret --token=VJ7fKLujME66Dut3bNx13xTBAaHg8ffo
kubectl config set-cluster tke-sdk-cluster --server=https://cls-p0jwiqj9.tencent-cloud.com --certificate-authority=$HOME/.ssh/tke-sdk.crt
kubectl config set-context tke-sdk --cluster=tke-sdk-cluster --user=tke-sdk-secret
kubectl config use-context tke-sdk

kubectl cluster-info
```


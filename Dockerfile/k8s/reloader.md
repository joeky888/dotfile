Helm install
=====
* Only default namespace is allowed
```sh
# helm repo add stakater https://stakater.github.io/stakater-charts
helm repo update
helm upgrade --install reloader stakater/reloader -n default
```

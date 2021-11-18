Install
=====
* Install traefik with helm chart
* Add `kubernetes.io/ingress.class: "traefik"`
* Add middlewares
* Basic yaml
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx
  annotations:
    kubernetes.io/ingress.class: "traefik"
    traefik.ingress.kubernetes.io/router.middlewares: ingress-test-compress@kubernetescrd # <NAMESPACE>-<NAME>@kubernetescrd
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx
            port:
              number: 80
---
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: test-compress
  namespace: ingress
  labels:
    app: traefik
spec:
  compress: {}
```

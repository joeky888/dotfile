Helm install (local)
=====
```sh
helm upgrade --install haproxy ./haproxy-ingress -n ingress --debug \
		--set controller.kind=DaemonSet \
		--set controller.service.type=LoadBalancer \
		--set controller.ingressClass=haproxy \
		--set controller.logging.traffic.address=stdout \
		--set controller.logging.traffic.format=raw \
		--set controller.logging.traffic.facility=daemon
```

Ingress
=====
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: haproxy
  annotations:
    kubernetes.io/ingress.class: "haproxy"
```

Log all pod of a deployment.apps/daemonset.apps
=====
* Use label filter is the only way to do right now
```sh
kubectl logs -f -l app.kubernetes.io/name=ingress-nginx --all-containers --tail 10 -n ingress
```


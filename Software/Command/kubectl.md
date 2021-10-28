Log all pod of a deployment.apps/daemonset.apps
=====
* Use label filter is the only way to do right now
```sh
kubectl logs -f -l app.kubernetes.io/name=ingress-nginx --all-containers --tail 10 -n ingress
```

kubectl get all too slow
=====
* Turn on verbose log to see the actual problems
* $ kubectl get all -v 9
* $ sudo rm -rf ~/.kube/cache # Remove the cache folder

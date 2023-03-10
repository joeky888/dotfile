Get pod count on each node, to see if pods reachs max number acceptable for a node
=====
```sh
for node in $(kubectl get nodes | awk '{if (NR!=1) {print $1}}'); do echo""; echo "Checking ${node}..."; kubectl describe node ${node} | grep "Non-terminated" ; done
```

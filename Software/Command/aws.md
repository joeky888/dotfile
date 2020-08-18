cli login
=====
* Open aws web -> Top right corner [account(name)] -> My Security Credentials
    * Copy Access key ID and Secret (Create new if secret is lost)
* $ aws configure

Manage key pairs (Create and Delete)
=====
* Open https://console.aws.amazon.com/ec2 -> NETWORK & SECURITY (On the left)
    * Key Pairs

Control EKS
=====
```sh
aws eks update-kubeconfig --name CLUSTER_NAME --region REGION_CODE
kubectl get all
```


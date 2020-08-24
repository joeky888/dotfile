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

CDN (AWS Cloudfront) for k8s ingress
=====
* Remove k8s https tls configs to make it http-only, because cloudfront goes https
* Create Cloudfront Distribution for one domain (a distribution is for one domain only)
    * Origin Domain Name: loadbalancer (http://xx.elb.ap-northeast-1.amazonaws.com) OR pure-ip(Non-lb)
    * Minimum Origin SSL Protocol: TLSv1.2
    * Origin Protocol Policy: HTTP only
    * Viewer Protocol Policy: Redirect HTTP to HTTPS
    * Allowed HTTP Methods: GET, HEAD, OPTIONS
    * Cache and origin request settings: Use legacy cache settings
        * Whitelist -> Add -> "Host"
    * Alternate Domain Names (CNAMEs) -> Add "www.mydomain.com"
        * Custom SSL Certificate (example.com) -> Request or Import a Certificate with ACM
            * Use cname validation
            * Go to godday/cloudflair add cname for aws certificate validation

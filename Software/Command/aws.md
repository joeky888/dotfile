cli login
=====
* Open aws web -> Top right corner [account(name)] -> My Security Credentials
    * Copy Access key ID and Secret (Create new if secret is lost)
* $ aws configure

Manage key pairs (Create and Delete)
=====
* Open https://console.aws.amazon.com/ec2 -> NETWORK & SECURITY (On the left)
    * Key Pairs

AMI list with image name and id
=====
* https://thecloudmarket.com

Control EKS
=====
```sh
aws eks update-kubeconfig --name CLUSTER_NAME --region REGION_CODE
kubectl get all
# If one is unable to control, see https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
kubectl describe configmap -n kube-system aws-auth # Should give something like this - userarn: arn:aws:iam::xxxxxxxxx:user/Joeky
# If the user is not in the configmap, add it manually from other aws iam user who has the permission to edit the configmap
kubectl edit -n kube-system configmap/aws-auth # Add userarn, username and groups undert the "mapUsers" field
```

AWS New iam user and groups
=====
* Add New group named "admin" and give it permission "AdministratorAccess" and "AWSBillingReadOnlyAccess"
* Add New group named "developer" and give it permission "AmazonEC2ContainerRegistryPowerUser"

CDN (AWS Cloudfront) for k8s ingress
=====
* Remove k8s https tls configs to make it http-only, because cloudfront goes https, otherwise will trigger error maximum redirects (20) exceeded
    * nginx.ingress.kubernetes.io/ssl-redirect: "false"
    * nginx.ingress.kubernetes.io/force-ssl-redirect: "false"
* Create Cloudfront Distribution for one domain (a distribution is for one domain only)
    * Origin Domain Name: loadbalancer (http://xx.elb.ap-northeast-1.amazonaws.com) OR pure-ip(Non-lb)
    * Origin Path: Leave it empty
    * Minimum Origin SSL Protocol: TLSv1.2
    * Origin Protocol Policy: HTTP only
    * Viewer Protocol Policy: Redirect HTTP to HTTPS
    * Allowed HTTP Methods: GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE
    * Cache and origin request settings:
        * Cache Policy -> Create a new policy -> Name it to "Forward-Host-Header"
            * Whitelist -> Add -> "Host", "Authorization", "Origin", "Referer"
        * Cache Policy -> Select "Forward-Host-Header"
    * Alternate Domain Names (CNAMEs) -> Add "www.mydomain.com"
        * Custom SSL Certificate (example.com) -> Request or Import a Certificate with ACM
            * Use cname validation
            * Go to godday/cloudflare add cname for aws certificate validation
    * Disable caches for /api/ route (Dynamic Content)
        * Create Behavior (New)
            * Path Pattern -> `/api/*`
            * Viewer Protocol Policy -> Redirect HTTP to HTTPS
            * Allowed HTTP Methods -> GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE
            * Cache Policy -> Managed-CachingDisabled
            * Origin Request Policy -> Managed-AllViewer

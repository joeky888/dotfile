cli login
=====
* Open aws web -> Top right corner [account(name)] -> My Security Credentials
  * Copy Access key ID and Secret (Create new if secret is lost)
```sh
aws configure
# Optional, with docker authentication
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```

Manage key pairs (Create and Delete)
=====
* Open https://console.aws.amazon.com/ec2 -> NETWORK & SECURITY (On the left)
  * Key Pairs

Generate aws compatible key pairs using cli
=====
```sh
ssh-keygen -t ed25519 # New way
ssh-keygen -m PEM # Old way
```

AMI list with image name and id
=====
* https://thecloudmarket.com
* Or ubuntu-only
* https://cloud-images.ubuntu.com/locator/ec2/
* Or
* Go to aws console -> EC2 -> AMIs (On the left panel) ->
  * Public images -> Check
  * Owner: 099720109477
  * Virtualization type: HVM
  * Platform: Ubuntu
  * AMI Name: 20.04
  * Architecture: x64
* Or for eks ami go to
* https://github.com/awslabs/amazon-eks-ami/releases

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
  * Make sure root account "IAM User and Role Access to Billing Information" is checked # https://www.youtube.com/watch?v=rWhnnqPTd6Y
* Add New group named "developer" and give it permission "AmazonEC2ContainerRegistryPowerUser"
* Add New group named "S3andDynamoOnly" and give it permission "AmazonS3FullAccess" and "AmazonDynamoDBFullAccess"

Low cost best practice
=====
* Cloudwatch -> Logs -> Log groups -> Set all "Retention"s to "1 week"

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
      * Set Domain name to wildchar domain `*.mydomain.com` and (optional) add original domain `mydomain.com`
      * Use DNS cname validation
      * Go to godday/cloudflare add cname for aws certificate validation
  * Disable caches for /api/ route (Dynamic Content)
    * Create Behavior (New)
      * Path Pattern -> `/api/*`
      * Viewer Protocol Policy -> Redirect HTTP to HTTPS
      * Allowed HTTP Methods -> GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE
      * Cache Policy -> Managed-CachingDisabled
      * Origin Request Policy -> Managed-AllViewer

S3 cors
=====
* Bucket policy
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1405592139000",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": [
                "arn:aws:s3:::xinango/*",
                "arn:aws:s3:::xinango"
            ]
        }
    ]
}
```
* Cross-origin resource sharing (CORS)
```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET",
            "HEAD"
        ],
        "AllowedOrigins": [
            "https://*.shian.fun",
            "https://*.xinan-ai.com",
            "https://xinan-ai.com"
        ],
        "ExposeHeaders": []
    },
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET",
            "HEAD",
            "POST",
            "PUT",
            "DELETE"
        ],
        "AllowedOrigins": [
            "https://*.frp.neplus.com.tw",
            "https://admin-dev.shian.fun",
            "https://admin-prod.shian.fun"
        ],
        "ExposeHeaders": []
    }
]
```

S3 cors with cloudfront
=====
* Behavior -> Edit
* Viewer protocol policy -> Redirect HTTP to HTTPS
* Allowed HTTP methods -> GET, HEAD, OPTIONS
  * Cache HTTP methods -> Check "OPTIONS"
* Cache policy -> CachingOptimized
* Origin request policy -> CORS-S3Origin
* Troubleshooting
  * Clear cache
    * Select distribution to clear -> Invalidations -> Create Invalidation -> Add "/" and "/*"


AWS SES
=====
* Go to ses aws console -> SMTP settings -> Create SMTP credentials -> enter "mail-user" -> Obtain the smtp user/password
* Go to ses aws console -> Identities -> Create identity, enter domain "mail.example.com"
* Finish DKIM verification -> Using "Easy DKIM"
* Use the access key from the "mail-user" and finish the php config
```yaml
driver: smtp
host: email-smtp.ap-northeast-1.amazonaws.com # email-smtp.<Region>.amazonaws.com
port: 587
from_address: mail-user@mail.example.com # iam-user@domain
username: AXXXXXXXXXXXXXXT # mail-user's smtp user # NOTE that this is not iam accesskey
password: BXXXXXXXXXXXXXXXz # mail-user's smtp password # NOTE that this is not iam secretkey
encryption: tls
from_name: Service
```
* Note that this only enables sandbox mode, in order to send email to non-aws mail like gmail
  * Goto aws ses console -> Get set up -> Request production access -> Compelete forms

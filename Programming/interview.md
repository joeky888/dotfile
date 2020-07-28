4 ways to control a Goroutine
=====
* Mutex lock
* Channel and Select
    * buffered channel and unbuffered channed (Async and Sync)
* Waitgroup, Errgroup
* Context
    * WithCancel - Use cancel() function to break goroutine
    * WithDeadline - Use timer to break goroutine

TLS and Security
=====
* When using https, POST data will be encrypted but GET won't
* JWT vs Cookie - cookie will be sent every time even on a img src html tag (CSRF attack)

Container
=====
* 3 things to control a k8s cluster, 1. password 2. api address 3. token
* K8s kind
    * Configmap vs Secret
        * Configmap
            * Plain text
            * For server env configs
            * Always "unchanged" if the data hasn't changed using `kubectl apply -f`
        * Secret
            * Bese64
            * For API keys, credentials
            * Always "configured" - even if the file hasn't changed using `kubectl apply -f`
    * Deployment vs Pod vs Service
        * Deployment - Creates pods by ReplicaSets
        * Pod - Create only a pod
        * Service - Open ports for Deployments
    * Job
        * One time running
    * ClusterRoleBinding and RoleBinding for higher permissions
        * Need to access/control other pods
        * Very like the `volumes: /var/run/docker.sock:/var/run/docker.sock` in docker-compose.yml
* grpc vs restful - grpc is a persistent tcp connection (長連接) and is better for communications in microservice
* Distributed Redis lock should add timeout to prevent crashing
* mq broadcasting
    * Multicast 多播
    * Loadbalance 單播


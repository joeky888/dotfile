Setup a docker swarm cluster using docker-machine
=====
* There are 3 physical machines
    * master is on 192.168.0.1
    * slave1 is on 192.168.0.2
    * slave2 is on 192.168.0.3
```sh
# on master
docker swarm init --advertise-addr 192.168.0.1
docker swarm join-token worker # Copy output and paste to all slaves

# On slave1
docker swarm join \
    --token SWMTKN-1-5k0kak7isw4dq221d6oh51hbb1b65pcvsl76p2tac5iadq8vab-7ngefy0w3926guu2rqgpt9gxy \
    192.168.0.1:2377
# On slave2
docker swarm join \
    --token SWMTKN-1-5k0kak7isw4dq221d6oh51hbb1b65pcvsl76p2tac5iadq8vab-7ngefy0w3926guu2rqgpt9gxy \
    192.168.0.1:2377

# On master
docker node ls
#docker network create -d overlay my-app # create a multi-host overlay network
#docker service ls
#docker service ps myservice
#docker service rm myservice
```

Remove a swarm
=====
* On the master
* $ docker node ls
* $ docker node rm -worker-node-id- --force
* Or on the slave
* $ docker swarm leave --force

Create a service
=====
* Create a Dockerfile which setup environment
    * One dockerfile per service
    * $ docker build -t mydockerfile .
    * $ docker tag ubuntu:latest joeky:latest # Optional
* Create a compose yaml file, which is the most difficult part
    * Include the joeky:latest image tag
* Make sure all masters and slaves have the same docker image
* $ docker stack deploy -c ./docker-compose.yml myapp
* $ docker stack ls
* $ docker stack ps --no-trunc myapp
* $ docker service inspect --pretty myapp
* $ docker service scale myapp=5 # Resize number of containers to run this
* $ docker stack rm myapp

Monitor
====
* Use docker-swarm-visualizer

How it works
=====
* [](http://thesecretlivesofdata.com/raft)


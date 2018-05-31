Setup a docker swarm cluster using docker-machine
=====
* There are 3 physical machines
    * master is on 192.168.0.1
    * slave1 is on 192.168.0.2
    * slave2 is on 192.168.0.3
```sh
# on master
docker swarm init --advertise-addr 192.168.0.1
docker swarm join-token manager # Copy output and paste to all slaves

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
docker network create -d overlay my-app # create a multi-host overlay network
```

Remove a swarm
=====
* On the target machine(swarm)
* $ docker swarm leave --force

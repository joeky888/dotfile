Turn on Hyper-V
=====
* Make sure Windows feature Hyper-V checked
* Run with admin cmd
* $ bcdedit /set hypervisorlaunchtype auto
* Reboot

Turn off Hyper-V
=====
* Make sure Windows feature Hyper-V checked
* Run with admin cmd
* $ bcdedit /set hypervisorlaunchtype off
* Reboot

Install docker on Linux
=====
```sh
# Install Docker Community Edition (Docker CE)
app-fast update && app-fast install docker.io -y
sudo usermod -aG docker $(whoami) # Or sudo adduser $(whoami) docker
exit # and then open the terminal again
systemctl status docker.service
sudo systemctl enable docker.service
sudo systemctl restart docker.service
```

Check if docker is running correctly
=====
* name it to hello-world then remove it
* $ docker run --name hello-world hello-world && docker rm hello-world

Show all installed container / just like showing all .vmdk on virtualbox
=====
* $ docker ps -a

All containers are stored at
=====
* Windows: "C:\Users\Public\Documents\Hyper-V\Virtual hard disks"

Remove an installed container / just like remove a .vmdk on virtualbox
=====
* $ docker rm containerID

Create a ubuntu container on docker
=====
* $ docker pull ubuntu # From Docker Hub
* $ docker images
* Create a container and name it to "ubuntu1"
* $ docker run -it --name ubuntu1 ubuntu bash
* $ dpkg-reconfigure tzdata # Set packages server location
```sh
sed -i "s/archive/tw.archive/" /etc/apt/sources.list
```
* edit /etc/apt/sources.list # Replace all "archive" to "tw.archive"
* edit /etc/apt/sources.list # Use devel packages
* Download and run dotfiles
* $ `locale-gen en_US.UTF-8`

Run an exist ubuntu container
=====
* $ docker ps -a # get the name of the container
* $ docker restart containerName
* $ docker exec -it containerName bash
* Or if trying to run container with tmux support
* $ docker exec -it ubuntu1 script -q -c "/bin/bash" /dev/null # ubuntu1 is container\_name

Take a snapshot of container and restore
=====
* Take a snapshot
* $ docker export containerName > ~/ubuntu1.tar
* Restore a snapshot to a docker image called "backup/ubuntu"
* $ docker stop ubuntu1 # ubuntu1 is containerName
* $ docker rm --force ubuntu1 # ubuntu1 is containerName
* $ cat ~/ubuntu1.tar | docker import - backup/ubuntu:v1.0
* $ docker run -it --name ubuntu1 backup/ubuntu:v1.0 bash
* $ docker restart ubuntu1

Remove a commit / snapshot1 image
=====
* $ docker rmi imageID

Remove all containers and images
=====
* $ docker system prune -a

Expose port
=====
* Host port 80 container port 8080
* $ docker -p 80:8080

Unable to ping/curl from outside of container
=====
* Change hostname from "127.0.0.1" to "0.0.0.0"
* $ ./myserver -host 127.0.0.1 # (X)
* $ ./myserver -host 0.0.0.0 # (O)

Multiple service in a container using Supervisord
=====
* `ENTRYPOINT ["/usr/bin/supervisord", "-c", "/cube/supervisord.conf", "--loglevel", "debug"]`
```dosini
# supervisord.conf

[supervisord]
nodaemon=true
stdout_logfile=/dev/stdout
stderr_logfile=/dev/stderr
stdout_events_enabled=true

[program:xvfb]
command=/usr/bin/Xvfb :1 -screen 0 1024x768x16
autorestart=true
user=root
priority=100
stdout_logfile=/dev/stdout
stderr_logfile=/dev/stderr
stdout_events_enabled=true

[program:cube]
environment =
    DISPLAY=":1",
    WINEPREFIX=/wine,
    WINEARCH=win64
command=sh -c "sleep 30s; /usr/bin/wine64 /cube/Server.exe"
autorestart=true
user=root
priority=200
stdout_logfile=/dev/stdout
stderr_logfile=/dev/stderr
stdout_events_enabled=true
```

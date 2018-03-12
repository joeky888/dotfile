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
sudo apt-fast update && sudo apt-fast install docker.io -y
sudo usermod -aG docker $USER
sudo reboot
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

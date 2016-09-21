Turn on Hyper-V
=====
* Make sure Windows feature Hyper-V checked
* Run with admin cmd
* $ bcdedit /set hypervisorlaunchtype auto
* Or
* $ bcdedit /set hypervisorlaunchtype on
* Reboot

Turn off Hyper-V 
=====
* Make sure Windows feature Hyper-V checked
* Run with admin cmd
* $ bcdedit /set hypervisorlaunchtype off
* Reboot

Check if docker is running correctly
=====
* name it to hello-world then remove it
* $ docker run --name hello-world hello-world && docker rm hello-world

Show all installed container / just like showing all .vmdk on virtualbox
=====
* $ docker ps -a

All container stored at
=====
* Windows: "C:\Users\Public\Documents\Hyper-V\Virtual hard disks"

Remove a installed container / just like remove a .vmdk on virtualbox
=====
* $ docker rm container_id

Create a ubuntu container on docker
=====
* use C:\cygwin64\Cygwin.bat
* $ zsh
* name it to "ubuntu1"
* $ docker run -it --name ubuntu1 ubuntu bash
* dpkg-reconfigure tzdata # Set packages server location
* edit /etc/apt/sources.list # Use devel packages
* Download and run dotfiles
* $ locale-gen en_US.UTF-8

Run a exist ubuntu container
=====
* $ docker ps -a # get the name of the container
* $ docker restart container_name
* $ docker exec -it container_name bash
* Or if trying to run container with tmux support
* $ docker exec -it container_name script -q -c "/bin/bash" /dev/null


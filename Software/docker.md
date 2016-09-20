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
* $ docker run hello-world

Show all installed container / just like showing all .vmdk on virtualbox
=====
* $ docker ps -a

Remove a installed container / just like remove a .vmdk on virtualbox
=====
* $ docker rm container_id

Install ubuntu container on docker
=====
* use C:\cygwin64\Cygwin.bat
* $ zsh
* $ docker run -it ubuntu bash
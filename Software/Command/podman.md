Install for windows (Failed)
=====
* $ scoop install podman
* $ pip3 install https://github.com/containers/podman-compose/archive/devel.tar.gz
* $ qemu-img create -f qcow2 podman.img 30G
* $ podman machine init --image-path C:\Users\joeky\Desktop\podman.img --cpus 2 --memory 2

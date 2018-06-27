Build and Run a dockerfile
=====
* build a image with a tag name debian:joeky
* $ cd $WhereDockerFilesExist
* $ docker build . -t debian:joeky
* $ docker images
* If the dockerfile has a line CMD["bash"]
* $ docker run --name j1 -it debian:joeky
* If the dockerfile doesn't have a line CMD["bash"]
* $ docker run --name j1 -it debian:joeky /bin/zsh

Run an exist container
=====
* $ docker ps -a # get the name of the container
* $ docker restart containerName
* $ docker exec -it containerName bash

Remove a dockerfile image
=====
* $ docker images
* $ docker rmi debian:joeky

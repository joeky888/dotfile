Build and Run a dockerfile
=====
* build a image with a tag name debian:joeky
* $ cd $WhereDockerFilesExist
* $ docker build . -t debian:joeky
* $ docker images
* If the dockerfile has a line CMD["bash"]
* $ docker run -i -t debian:joeky
* If the dockerfile doesn't have a line CMD["bash"]
* $ docker run -i -t debian:joeky /bin/zsh

Remove a dockerfile image
=====
* $ docker images
* $ docker rmi debian:joeky

Remove a container
=====
* $ docker rm containerID

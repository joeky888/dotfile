Service with a bot to restart service when it is stopped
=====
```yaml
####################################
# controllers
#     └── dataController.js
# Dockerfile-node
#     └── Dockerfile
# Dockerfile-postbot-localhost
#     ├── bot.sh
#     └── Dockerfile
# docker-compose.yml
####################################

version: '3'
services:
  controller:
      image: han:20180101node
      build:
          context: ./
          dockerfile: ./Dockerfile-node/Dockerfile
      container_name: controller
      restart: always
      ports:
       - "8080:8080"

  controllerbot:
      image: hanbot:20180101
      build:
          context: ./
          dockerfile: ./Dockerfile-postbot-localhost/Dockerfile
      container_name: controllerbot
      restart: always
      network_mode: host
      volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
* Run
  * `docker-compose up -d`
  * Or
  * `docker-compose -f docker-compose.yml up -d`
* Hot-reload the service with code up-to-date
  * `docker-compose up -d --no-deps --build <service_name>`

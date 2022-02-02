docker-compose for arm64 on gitea.example.com
=====
* Customized from https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini
* Auto https cert via Caddy/Traefik
* gitea ssh container port 22 forwards to host port 2222 (client -> host 22 -> host 2222 -> container 22)
* Make sure
  * Port 22 is used for sshd on the host
  * gitea.example.com is registerd and pointed to the server address
  * Server is arm64 based. Otherwise change the docker image tag
  * No CDN is used, don't use cloudflare/cloudfront it will block port 22 forwarding
  * Minimal ram is 512MB, but 1GB is recommended
  * Minimal cpu is 1 vcpu
* Steps
```sh
# Create a user named git
sudo useradd --create-home --system --user-group --home-dir /home/git --shell /bin/bash git
sudo su git
id # edit USER_UID and USER_GID in docker-compose
ssh-keygen -t rsa -b 4096 -C "Gitea Host Key"
echo "$(cat /home/git/.ssh/id_rsa.pub)" >> /home/git/.ssh/authorized_keys
exit

# Add the following content on the host
sudo mkdir -p /app/gitea/
sudoedit /app/gitea/gitea # This is a host path, not container
# Add this line to the file
ssh -p 2222 -o StrictHostKeyChecking=no git@127.0.0.1 \
    "SSH_ORIGINAL_COMMAND=\"$SSH_ORIGINAL_COMMAND\" $0 $@"

sudo chmod +x /app/gitea/gitea
docker-compose up -d --build
```

```yaml
version: "3.4"
services:
  autoheal:
    restart: always
    image: willfarrell/autoheal
    environment:
      - AUTOHEAL_CONTAINER_LABEL=all
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
  gitea:
    image: gitea/gitea:1.14.2
    container_name: gitea
    environment:
      - USER_UID=1000 # Chage this by using `id` command for the user git
      - USER_GID=1000
      - GITEA__server__ROOT_URL=https://gitea.example.com
      - GITEA__server__SSH_DOMAIN=gitea.example.com
      - GITEA__server__ENABLE_GZIP=true
      - GITEA__database__DB_TYPE=postgres
      - GITEA__database__HOST=postgres:5432
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=gitea
      - GITEA__database__PASSWD=gitea
      - GITEA__cache__ENABLED=true
      - GITEA__cache__ADAPTER=memory
      - GITEA__service__DISABLE_REGISTRATION=true
      - GITEA__service__REQUIRE_SIGNIN_VIEW=true
      - GITEA__repository__FORCE_PRIVATE=true
      - GITEA__ui__DEFAULT_THEME=arc-green # Per-user theme setting can be found Settings -> Account -> Select default theme
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.gitea.rule=Host(`gitea.example.com`)"
      - "traefik.http.routers.gitea.entrypoints=websecure"
      - "traefik.http.routers.gitea.tls=true"
      - "traefik.http.routers.gitea.tls.certresolver=letsencrypt"
      - 'traefik.http.routers.gitea.service=giteaservice'
      - 'traefik.http.services.giteaservice.loadbalancer.server.port=3000'
      - "traefik.http.middlewares.gitea_gzip.compress=true"
      - "traefik.http.routers.gitea.middlewares=gitea_gzip@docker"
      # Block login api
      - "traefik.http.routers.gitea_login.rule=Host(`gitea.example.com`) && PathPrefix(`/user/login`)"
      - "traefik.http.routers.gitea_login.tls=true"
      - 'traefik.http.routers.gitea_login.service=gitea_loginservice'
      - 'traefik.http.services.gitea_loginservice.loadbalancer.server.port=3000'
      - "traefik.http.middlewares.gitea_login_whitelist.ipwhitelist.sourcerange=10.0.0.0/8,172.16.0.0/12,<OFFICE_IP>"
      # - "traefik.http.middlewares.gitea_login_whitelist.ipwhitelist.ipstrategy.depth=2"
      - "traefik.http.routers.gitea_login.middlewares=gitea_login_whitelist@docker"
      - "traefik.http.routers.gitea_login.entrypoints=websecure"
    restart: always
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:3000"]
      interval: 60s
      timeout: 10s
      start_period: 45s
      retries: 5
    depends_on:
      - postgres
    volumes:
      - /home/gitea/gitea:/data
      - /home/git/.ssh/:/data/git/.ssh
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      # - "3000:3000" # (Optional) Forwarding this port is for debugging purposes only, Caddy/Traefik uses docker network to access it
      - "127.0.0.1:2222:22" # 127.0.0.1:2222 This ensures port 2222 is not avaialbe from public internet
  postgres:
    image: arm64v8/postgres:13.3-alpine
    restart: always
    volumes:
      - /home/gitea/gitea-db:/var/lib/postgresql/data/
    environment:
      POSTGRES_DB: gitea
      POSTGRES_USER: gitea
      POSTGRES_PASSWORD: gitea
      TZ: "Asia/Taipei"

  traefik:
    image: "traefik:v2.5"
    container_name: "traefik"
    restart: always
    command:
      # - "--log.level=DEBUG"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"
      - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      - "--entrypoints.web.http.redirections.entryPoint.scheme=https"
      - "--entrypoints.web.http.redirections.entrypoint.permanent=true"
      - "--certificatesresolvers.letsencrypt.acme.httpchallenge=true"
      - "--certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=web"
      #- "--certificatesresolvers.letsencrypt.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"
      - "--certificatesresolvers.letsencrypt.acme.email=<ACME-EMAIL>"
      - "--certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json"
      # Enable http3, make sure aws security group has udp enabled on port 443
      - "--experimental.http3=true"
      - "--entrypoints.websecure.enablehttp3=true"
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:8080"]
      interval: 10s
      timeout: 5s
      start_period: 5s
      retries: 5
    ports:
      - "443:443/udp"
      - "443:443/tcp"
      - "80:80"
    volumes:
      - "/home/letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
    depends_on:
      - gitea
#  caddy:
#    image: caddy:2.4.0
#    restart: always
#    healthcheck:
#      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:2019/metrics"]
#      interval: 60s
#      timeout: 10s
#      start_period: 45s
#      retries: 5
#    command: [caddy, reverse-proxy, --from, gitea.example.com, --to, gitea:3000]
#    ports:
#      - 80:80
#      - 443:443
#    depends_on:
#      - gitea
```

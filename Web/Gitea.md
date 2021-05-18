docker-compose for arm64 on gitea.example.com
=====
* Customized from https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini
* Auto https cert via Caddy
* gitea ssh container port 22 forwards to host port 2222 (client -> host 22 -> host 2222 -> container 22)
* Make sure
  * Port 22 is used for sshd on the host
  * gitea.example.com is registerd and pointed to the server address
  * Server is arm64 based. Otherwise change the docker image tag
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
version: "3"
services:
  gitea:
    image: gitea/gitea:1.14.2
    container_name: gitea
    environment:
      - USER_UID=1000 # Chage this by using `id` command for the user git
      - USER_GID=1000
      - GITEA__server__ROOT_URL=https://gitea.example.com
      - GITEA__server__SSH_DOMAIN=gitea.example.com
      - GITEA__database__DB_TYPE=postgres
      - GITEA__database__HOST=postgres:5432
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=gitea
      - GITEA__database__PASSWD=gitea
      - GITEA__cache__ENABLED=true
      - GITEA__cache__ADAPTER=redis
      - GITEA__cache__HOST=redis://redis:6379/0?pool_size=100&idle_timeout=180s
      - GITEA__service__DISABLE_REGISTRATION=true
      - GITEA__repository__FORCE_PRIVATE=true
      - GITEA__ui__DEFAULT_THEME=arc-green
    restart: always
    depends_on:
      - postgres
      - redis
    volumes:
      - /home/gitea/gitea:/data
      - /home/git/.ssh/:/data/git/.ssh
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "3000:3000"
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
  redis:
    image: redis:6.2.0-alpine3.13
    restart: always
    entrypoint: [redis-server, --port, "6379"]
  caddy:
    image: caddy:2.4.0
    restart: always
    command: [caddy, reverse-proxy, --from, gitea.example.com, --to, gitea:3000]
    ports:
      - 80:80
      - 443:443
    depends_on:
      - gitea
```
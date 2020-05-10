Install
=====
```sh
npm install -g redis-commander@latest
rm ~/.npm-packages/lib/node_modules/redis-commander/config/local-development.json
```

Usage
=====
```sh
redis-commander --clear-config
redis-commander --redis-host 127.0.0.1 --redis-port 6379 --redis-password "xxxx" --noload --nosave --port 8088
```

docker compose
=====
```yaml
version: '3'
services:
  redis:
    container_name: redis
    hostname: redis
    image: redis
    ports:
      - 6379:6379
    command: ['redis-server', '--requirepass', '123456']

  redis-commander:
    container_name: redis-commander
    hostname: redis-commander
    image: rediscommander/redis-commander:latest
    restart: always
    environment:
    - REDIS_HOST=redis
    - REDIS_PORT=6379
    - REDIS_PASSWORD=123456
    ports:
    - "8081:8081"
```

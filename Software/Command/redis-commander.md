Install
=====
```sh
npm install -g redis-commander@latest
rm ~/node/lib/node_modules/redis-commander/config/local-development.json
```

Usage
=====
```sh
redis-commander --clear-config
redis-commander --redis-host 127.0.0.1 --redis-port 6379 --redis-password "xxxx" --noload --nosave --port 8088
```

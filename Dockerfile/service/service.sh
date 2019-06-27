#!/bin/bash

# Mysql 5.7 root with password 123456
docker run --name mysql -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# Mysql 5.7 with username libgo password 123456
docker run --name mysql -p 3306:3306 -e MYSQL_USER=libgo -e MYSQL_PASSWORD=123456 -d mysql:5.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# Redis latest
docker run --name redis -p 6379:6379 -d redis

#!/bin/sh

echo "window.env={}" > /usr/share/nginx/html/env.js

# Get all variables start with "APP"
env | grep "^APP" |
while read -r line
do
    echo "window.env.$(echo $line | sed -e 's/=/=\"/' -e 's/$/\"/')" | tee -a /usr/share/nginx/html/env.js
done;

ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log

nginx -g "daemon off;"
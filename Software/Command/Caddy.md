Automatically https from localhost:8080 for example.com
=====
* Add Caddyfile
```conf
example.com

reverse_proxy 127.0.0.1:8080
```
* $ caddy run --config ./Caddyfile

Automatically https from localhost:8080 for example.com
=====
* Add Caddyfile
```conf
example.com {
  reverse_proxy 127.0.0.1:8080
}

admin.example.com {
  reverse_proxy 127.0.0.1:8081
}
```
* $ caddy run --config ./Caddyfile

Automatically https from localhost:8080 for example.com (one-liner)
=====
* $ caddy reverse-proxy --from example.com --to 127.0.0.1:8080

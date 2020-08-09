Download old link of Geolite2
=====
https://web.archive.org/web/20191227182209/https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
https://web.archive.org/web/20191227182412/https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz
https://web.archive.org/web/20191227182527/https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz
https://web.archive.org/web/20191227182816/https://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip
https://web.archive.org/web/20191227183011/https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country-CSV.zip
https://web.archive.org/web/20191227183143/https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN-CSV.zip

Download Geolite1
=====
* https://www.miyuru.lk/geoiplegacy

.DAT format (Geolite1) for nginx in docker
=====
* Download geoip.dat from archlinux package "geoip-database"
* Redirect www.example.com to cn.example.com for china
```conf
load_module modules/ngx_http_geoip_module.so;

http{
    geoip_country /usr/share/nginx/geoip.dat; # <--- import .dat file here

    server {
        listen       80;
        listen  [::]:80;
        server_name  localhost;

        location / {
            if ($geoip_country_code = CN) {
                rewrite ^ $scheme://cn.example.com$request_uri? redirect;
            }
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }
    }
}
```

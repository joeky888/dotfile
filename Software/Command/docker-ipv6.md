Make sure ipv6 is available on the host
=====
```sh
ping6 ipv6.google.com
curl -6 google.com
```

Enable ipv6
=====
```sh
sudoedit /lib/systemd/system/docker.service
# Append this to line `ExecStart=/usr/bin/dockerd`
--ipv6 --fixed-cidr-v6 2001:db8:1::/64
sudo systemctl daemon-reload
sudo systemctl restart docker
systemctl status docker # Make sure it is running with `--ipv6` command
```

docker compose openvpn ipv6 example
=====
```yaml
version: '2.1'
services:
  openvpn:
    cap_add:
     - NET_ADMIN
     - SYS_MODULE
    image: kylemanna/openvpn
    container_name: openvpn
    ports:
     - "1194:1194/udp"
    restart: always
    volumes:
      - /home/vpn/openvpn:/etc/openvpn
    sysctls:
      - net.ipv6.conf.all.disable_ipv6=0
      - net.ipv6.conf.default.forwarding=1
      - net.ipv6.conf.all.forwarding=1
    networks:
      network-openvpn:


networks:
  network-openvpn:
    enable_ipv6: true
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.27.1.0/24
        - subnet: fdcb:37eb:3cf0:73c3::/64
```

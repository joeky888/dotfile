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

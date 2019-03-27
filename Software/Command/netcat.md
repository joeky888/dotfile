Cli
=====
* On most unix it is called `nc`
* Nmap implementation is called `ncat`

Usage
=====
```sh
# Check a port is opening or not
nc -v 192.168.0.1 5000

# Scan tcp port 1-1000 and 2000-3000
nc -vnz -w 1 192.168.0.1 1-1000 2000-3000

# Scan udp port 1-1000 and 2000-3000
nc -vnzu 192.168.0.1 1-1000 2000-3000
```

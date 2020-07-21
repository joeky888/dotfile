Cli
=====
* On most unix it is called `nc`
* Nmap implementation is called `ncat`
* Some system may call it `netcat`

Usage
=====
* -z : Port scanning mode i.e. zero I/O mode.
* -v : Be verbose [use twice -vv to be more verbose].
* -n : Use numeric-only IP addresses i.e. do not use DNS to resolve ip addresses.
* -w 1 : Set time out value to 1.
```sh
# Scan tcp port 1-1000 and 2000-3000
nc -vnz -w 1 127.0.0.1 1-1000 2>&1 | grep succeeded
nc -vnz -w 1 127.0.0.1 2000-3000 2>&1 | grep succeeded

# Scan udp port 1-1000 and 2000-3000
nc -vnzu 127.0.0.1 1-1000 2>&1 | grep succeeded
nc -vnzu 127.0.0.1 2000-3000 2>&1 | grep succeeded
```
* Usage of netcat from nmap
```sh
# Scan tcp port 1-1000 and 2000-3000
ncat -vnz -w 1 127.0.0.1 1-1000 2>&1 | grep succeeded
ncat -vnz -w 1 127.0.0.1 2000-3000 2>&1 | grep succeeded

# Scan udp port 1-1000 and 2000-3000
ncat -vnzu 127.0.0.1 1-1000 2>&1 | grep succeeded
ncat -vnzu 127.0.0.1 2000-3000 2>&1 | grep succeeded
```

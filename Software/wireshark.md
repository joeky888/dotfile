Filter
=====
* `frame contains "mozilla"` – search for the string “mozilla” anywhere in the packet
* `tcp.port == 443` – tcp port is 443
* `dns.resp.len > 0` – all DNS responses
* `ip.addr == 52.7.23.87` – source or dest IP address is 52.7.23.87
* `ip.src==192.168.0.0/16 and ip.dst==192.168.0.0/16` Only show a range of IPs
* `(ip.src == XXX.XXX.XXX.XXX && (tcp.srcport == YYY || udp.srcport == YYY)) || (ip.dst == XXX.XXX.XXX.XXX && (tcp.dstport == YYY || udp.dstport == YYY)` Show XXX.XXX.XXX.XXX:YYY

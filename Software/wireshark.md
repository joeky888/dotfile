Wireshark without sudo
=====
* $ sudo groupadd wireshark
* $ sudo usermod -aG wireshark $(whoami)
* $ sudo reboot
* $ wireshark

Setting
=====
* Select network interface
    * Capture -> Options -> (select the interface) -> Start
* View -> Time Display Format -> Date and Time of Day
* View -> Name Resolution -> Check all three options

Filter
=====
```sh
# Search key word
frame contains "mozilla"

# Search only http port 80
http

# Searcb tcp port 443 on either src or dst
tcp.port == 443

# All DNS responses
dns.resp.len > 0

# Either source or dest IP address is 52.7.23.87
ip.addr == 52.7.23.87

# Only show a range of IPs
ip.src==192.168.0.0/16 and ip.dst==192.168.0.0/16

# Show aaa.aaa.aaa.aaa:bbb on src or ccc.ccc.ccc.ccc:ddd on dst
(ip.src == aaa.aaa.aaa.aaa && (tcp.srcport == bbb || udp.srcport == bbb)) || (ip.dst == ccc.ccc.ccc.ccc && (tcp.dstport == ddd || udp.dstport == ddd)

# Search for host name
http.host == "example.com"
```

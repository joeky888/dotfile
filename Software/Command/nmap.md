Scan mac address and ip on local network
======
* $ ifconfig -a # Get myip
* nmap -sn myip/24
* $ sudo nmap -sn 192.168.1.0/24 # sudo is required to get mac addresses

Check a port is open or not on the host
=====
* $ nmap 192.168.0.1 -p 5901

Scan all open port on the host
=====
* $ nmap -p- 192.168.0.1

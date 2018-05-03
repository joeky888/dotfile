Scan mac address and ip on local network
======
* $ ifconfig -a # Get myip
* nmap -sn myip/24
* $ sudo nmap -sn 192.168.1.0/24 # sudo is required to get mac addresses

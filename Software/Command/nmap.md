Scan mac address and ip on local network
======
* $ ip a # Get myip
* $ ifconfig -a # Get myip
* nmap -sn myip/24
* $ sudo nmap -sn 192.168.1.0/24 # sudo is required to get mac addresses
* Or
* $ arp -a # Windows only
```conf
192.168.1.0/24 的 24 指的是子網路遮罩

IP: 192.168.1.0
子網路: 255.255.255.0
也可以直接寫成 192.168.1.0/24

因爲
08 -> 11111111 00000000 00000000 00000000 -> 255.0.0.0
16 -> 11111111 11111111 00000000 00000000 -> 255.255.0.0
24 -> 11111111 11111111 11111111 00000000 -> 255.255.255.0
32 -> 11111111 11111111 11111111 11111111 -> 255.255.255.255

192.168.1.0/8  -> 掃描 192.x.x.x
192.168.1.0/16 -> 掃描 192.168.x.x
192.168.1.0/24 -> 掃描 192.168.1.x
192.168.1.0/32 -> 掃描 192.168.1.0
```

Check a port is open or not on the host
=====
* $ nmap 192.168.0.1 -p 5901

Scan all open ports on the host
=====
* $ nmap -p- 192.168.0.1
* Or
* $ nmap -Pn -p- 192.168.0.1

Scan a range of ports on the host
=====
* Scan ports 1000~1024 and 1025~9999
* $ nmap -p 1000-1024,1025-9999 127.0.0.1

Scan with progress bar
=====
* Method 1: manually get progress
    * $ nmap -p- localhost
    * Press enter/space/up/down/left/right keys on the keyboard
* Method 2: Refresh every 2 seconds
* $ alias nmap='nmap --stats-every 2s'

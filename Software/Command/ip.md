Subnet Mask 子網路遮罩
=====
```
192.168.1.0/24 的 24 指的是子網路遮罩

IP: 192.168.1.0
子網路: 255.255.255.0
也可以直接寫成 192.168.1.0/24

因爲
 8 -> 11111111 00000000 00000000 00000000 -> 255.0.0.0
16 -> 11111111 11111111 00000000 00000000 -> 255.255.0.0
24 -> 11111111 11111111 11111111 00000000 -> 255.255.255.0
32 -> 11111111 11111111 11111111 11111111 -> 255.255.255.255

192.168.1.0/8  -> 掃描 192.x.x.x
192.168.1.0/16 -> 掃描 192.168.x.x
192.168.1.0/24 -> 掃描 192.168.1.x
192.168.1.0/32 -> 掃描 192.168.1.0
```

Default GetWay 預設閘道
=====
```
所謂的預設閘道是指 Default GetWay , 白話一點的意思是說
, 當你在一個區網裡頭, 要對外連出去時 , 會經過的那個出口
, 一般這個出口就是指你的 SERVER ,
或是如果你是裝 IP 分享器的話 , 這個出口就是指你的分享器
, 所以當你查設定時, 會發現你的 GetWay 是指到你的分享器 IP
```

Get ip and Subnet Mask
=====
* $ ip a

Get Default GetWay
=====
* $ ip route | awk '/default/ { print $3 }'

Set ip redirection (Use route)
=====
```sh
# 雙網卡 eth0 eth1
# eth0 爲內部網路網卡 eth1 爲外部網路網卡

# 設定 Server 將 10.x.x.x 進來的 ip 經由 eth0 導出到 ip 爲 10.78.20.1 的內網路由器1號
route add -net 10.0.0.0 netmask 255.0.0.0 gw 10.78.20.1 dev eth0
# 設定 Server 將 172.x.x.x 進來的 ip 經由 eth0 導出到 ip 爲 10.78.20.1 的內網路由器1號
route add -net 172.0.0.0 netmask 255.0.0.0 gw 10.78.20.1 dev eth0
# 設定 Server 將其他所有進來的 ip 經由 eth1 導出到 ip 爲 192.168.0.1 的外網路由器2號
route del -net 0.0.0.0 netmask 0.0.0.0 gw 10.78.20.1 dev eth0
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.168.0.1 dev eth1
```

Set ip redirection (Use ip)
=====
```sh
# 雙網卡 eth0 eth1
# eth0 爲內部網路網卡 eth1 爲外部網路網卡

# 設定 Server 將 10.x.x.x 進來的 ip 經由 eth0 導出到 ip 爲 10.78.20.1 的內網路由器1號
ip route add 10.0.0.0/8 via 10.78.20.1 dev eth0
# 設定 Server 將 172.x.x.x 進來的 ip 經由 eth0 導出到 ip 爲 10.78.20.1 的內網路由器1號
ip route add 172.0.0.0/8 via 10.78.20.1 dev eth0
# 設定 Server 將其他所有進來的 ip 經由 eth1 導出到 ip 爲 192.168.0.1 的外網路由器2號
ip route delete 0.0.0.0/0 via 192.168.0.1 dev eth0
ip route add 0.0.0.0/0 via 192.168.0.1 dev eth1
```

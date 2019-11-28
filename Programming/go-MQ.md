Multicast vs Load Balancer
=====
* Multicast broadcasts messages to every subscribers
    * For clients like WebSocket broadcasting
* Load Balancer broadcasts to one of the subscribers
    * For clients like multiple workers

NSQ
=====
* NSQ is a topic/channel pattern
* NSQ is Load Balancer type
* NSQ can be Multicast type if there are more than one channel

NATS
=====
* Nats clients support both Multicast and Load Balancer
* client.Subscribe for Multicast
* client.QueueSubscribe for Load Balancer (Like NSQ topice/channel)


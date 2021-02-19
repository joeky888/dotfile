Multicast vs Load Balancer(Unicast)
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
* client.QueueSubscribe for Load Balancer (Like NSQ topic/channel)

KAFKA
=====
* Producer
    * Message in -> producer -> brocker cluster -> cunsumer
    * Partitions
        * A topic has multiple partitions
        * When a message is sent to a topic, only one partition will receive (Load Balancer)
        * a partition will store every messages with an unique id called "offsets"
        * Different partitions will probably has the same "offsets" because offsets are only unique for a partition, not unique for every partition
* Consumer
    * KAFKA has "consumer group" and "consumer(s)" in each group
    * KAFKA will Multicast to every consumer group
    * Only one consumer will receive the message in the same consumer group (Load Balancer)
    * Eg. 1 topic 3 groups 6 consumers (each group has 2 consumers)
        * the topic wiil Multicast to these 3 groups
        * only 1 consumer will receive the message in the same consumer group (Load Balancer)

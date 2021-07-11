### grpc vs mq

|                   | grpc                     | mq                                               |
| ----------------- | ------------------------ | ------------------------------------------------ |
| Performance       | Fast                     | Slow (because of a middleware server)            |
| Broadcasting      | No                       | Yes                                              |
| Pub/Sub Pattern   | No                       | Yes                                              |
| Failure tolerance | No                       | Yes (At-Least-Once)                              |
| Persistence       | No                       | Yes (Copied to disk to ensure data transmission) |
| Protocol          | plain http/2 without tls | tcp                                              |
| Use cases         | Request–reply            | Publish/subscribe, Data pipeline                 |

### MQTT QoS

| QoS | title         | meaning                                       | performance |
| --- | ------------- | --------------------------------------------- | ----------- |
| 0   | At most once  | fire and forget, no guarantee                 | fast        |
| 1   | At least once | acknowledged delivery, data may receive twice | medium      |
| 2   | Exactly once  | assured delivery                              | slow        |

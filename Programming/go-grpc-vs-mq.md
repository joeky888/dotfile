### grpc vs mq

|                   | grpc                     | mq                                               |
| ----------------- | ------------------------ | ------------------------------------------------ |
| Performance       | Fast                     | Slow (because of a middleware server)            |
| Broadcasting      | No                       | Yes                                              |
| Pub/Sub Pattern   | No                       | Yes                                              |
| Failure tolerance | No                       | Yes (At-Least-Once)                              |
| Persistence       | No                       | Yes (Copied to disk to ensure data transmission) |
| Protocol          | plain http/2 without tls | tcp                                              |

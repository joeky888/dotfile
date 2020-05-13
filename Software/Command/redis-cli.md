Connect to server
=====
* redis-cli -h host -p port -a password
* $ redis-cli -h 127.0.0.1 -p 6379 -a "password"

Set vs HSet vs HMSet
=====
* Set is for single-value fields
* HSET is for namespace-prefixed fields
* HMSet is like HSet but it sets multiple fields at one time

Set field value with namespace-prefixed
=====
* $ HSET namespace field value
* $ HGET namespace field
* $ HGETALL namespace

Set a password to a new redis server
=====
* $ CONFIG SET requirepass "mypass"
* Or
* $ redis-server --requirepass yourpassword


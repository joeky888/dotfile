Install
=====
* $ pip2 install -U sqlmap

Usage
=====
```sh
sqlmap --all --level=5 --risk=3 -u 'http://localhost/api/general/login' -H 'Content-Type: application/json' --data='{"Username":"user","Password":"12345678"}'
```

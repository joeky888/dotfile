ssh-keygen
=====
* ssh-keygen on ComputerA
```bash
ssh-keygen
```
* Copy id\_rsa.pub to ComputerB ~/.ssh/id\_rsa.pub
* cat id\_rsa.pub >> ~/.ssh/authorized\_keys on ComputerB

ssh
=====
* A = 192.168.0.1:8888 and B = 192.168.0.2:8888
* Connect from A to B
```bash
ssh username@192.168.0.2 -p 8888
```

ssh-keygen
=====
* ssh-keygen on ComputerA
```bash
ssh-keygen
Copy ~/.ssh/id_rsa.pub from ComputerA to ~/.ssh/id_rsa.pub on ComputerB
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys on ComputerB
```

ssh
=====
* A = 192.168.0.1:8888 and B = 192.168.0.2:8888
* Connect from A to B
```bash
ssh username@192.168.0.2 -p 8888
```

What if I use 3G/4G/Wi-fi on client
=====
* Maybe mosh (mobile ssh) can help

ssh-keygen
=====
* ssh-keygen on ComputerA
```sh
ssh-keygen
Copy ~/.ssh/id_rsa.pub from ComputerA to ~/.ssh/id_rsa.pub on ComputerB
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys on ComputerB
```

ssh
=====
* A = 192.168.0.1:8888 and B = 192.168.0.2:8888
* Connect from A to B
```sh
ssh B_username@192.168.0.2 -p 8888 -t tmux attach || tmux new
```

ssh config file
=====
* $ sudo apt install netcat -y # For proxy
* $ mkdir -p ~/.ssh
* $ vim ~/.ssh/config
* $ chown $USER ~/.ssh/config
* $ chmod 644 ~/.ssh/config
```conf
Host alias-name
    HostName server.name
    Port port-number
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private_ssh_file
    User username-on-remote-machine
    ProxyCommand ssh proxyuser@proxy.example.com -p proxyport nc %h %p 2> /dev/null
```
* $ ssh alias-name # Enter the proxy password, then enter the host user password

scp
=====
* A = 192.168.0.1:8888 and B = 192.168.0.2:8888
* Copy from A to B
```sh
scp –P 8888 A_username@192.168.0.1:~/foobar.txt /some/local/directory
```

ssh File transferring with GUI
=====
* Both Filezilla and Gnome Files (Nautilus) will work
* Connect to server with ssh:// or sftp://

What if I use 3G/4G/Wi-fi on client
=====
* Maybe mosh (mobile ssh) can help

Find and compare the Randomart of the existing ssh key
=====
```sh

ssh-keygen -lv -f ~/.ssh/id_rsa
+---[RSA 2048]----+
|                 |
|           .     |
| .    o   *      |
|. E  + o = =     |
|+...o . S +      |
|*+=..  + o       |
|=B.* o  +..      |
|* o.B +o+.. .    |
| oo+o=.+ ..o     |
+----[SHA256]-----+

ssh-keygen -lv -f ~/.ssh/id_rsa.pub
+---[RSA 2048]----+
|                 |
|           .     |
| .    o   *      |
|. E  + o = =     |
|+...o . S +      |
|*+=..  + o       |
|=B.* o  +..      |
|* o.B +o+.. .    |
| oo+o=.+ ..o     |
+----[SHA256]-----+
```

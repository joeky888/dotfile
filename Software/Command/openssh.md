ssh-keygen
=====
* ssh-keygen on ComputerA
```sh
ssh-keygen
```
* Remove ~/dotfile on the ComputerB
```sh
ssh user@ComputerB "mkdir -p ~/.ssh ; echo \"`cat ~/.ssh/id_rsa.pub`\" >> ~/.ssh/authorized_keys"
ssh-copy-id -i ~/.ssh/id_rsa.pub user@ComputerB # Alternative way
```

ssh
=====
* A = 192.168.0.1:8888 and B = 192.168.0.2:8888
* Connect from A to B
```sh
ssh B_username@192.168.0.2 -p 8888 -t tmux attach || tmux new
```

Port forward (using ssh tunnel)
=====
* ssh -NfL LocalPort:ServerHost:ServerPort user@server
    * -N Don't execute command
    * -f Run in background
    * -L Enable ssh tunnel
```sh
# Forward 192.168.1.102:80 to localhost:31280 via 168.95.1.1
ssh -NfL 31280:192.168.1.102:80 user@168.95.1.1
pkill ssh
```

ssh config file
=====
* $ sudo apt install netcat -y # For proxy
* $ mkdir -p ~/.ssh
* $ touch ~/.ssh/config
* $ chown $USER ~/.ssh/config
* $ chmod 644 ~/.ssh/config
* $ vim ~/.ssh/config
```conf
Host alias-name
    HostName server.name
    Port port-number
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private_ssh_file
    User username-on-remote-machine
    ProxyCommand ncat --proxy 127.0.0.1:1080 %h %p
    #ProxyCommand ssh proxyuser@proxy.example.com -p proxyport nc %h %p 2> /dev/null
    #ProxyCommand nc -X connect -x 127.0.0.1:1080 %h %p
    #ProxyCommand nc.openbsd -X connect -x 127.0.0.1:1080 %h %p
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

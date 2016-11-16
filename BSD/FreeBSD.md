Initialize ports tree (Do this for the first time)
=====
* $ portsnap fetch
* $ portsnap extract

Update ports tree
=====
* $ portsnap fetch update

Search and Install ports packages
=====
* $ whereis tmux
* $ cd /usr/ports/sysutils/tmux
* $ export BATCH=yes
* $ make install clean

Uninstall paorts packages
=====
* $ whereis tmux
* $ cd /usr/ports/sysutils/tmux
* $ make deinstall

Upgrade all ports packages
=====
* $ portupgrade -a

Add user to sudoer
=====
* $ whereis sudo
* $ cd /usr/ports/security/sudo
* $ make install clean
* $ visudo
````
##
## User privilege specification
##
root  ALL=(ALL) ALL
joeky ALL=(ALL) ALL
````

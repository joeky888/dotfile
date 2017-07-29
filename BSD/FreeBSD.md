Initialize ports tree (Do this for the first time)
=====
* Login as root
* $ portsnap fetch extract

Update ports tree
=====
* Login as root
* $ portsnap fetch update

Search and Install ports packages
=====
* $ whereis zsh
* $ cd /usr/ports/shells/zsh
* $ export BATCH=yes
* For root
* $ make install clean
* $ chsh -s zsh root
* For sudoers
* $ sudo -E make install clean # -E means preserving env variables

Uninstall paorts packages
=====
* $ whereis zsh
* $ cd /usr/ports/shells/zsh
* $ make deinstall

Upgrade all ports packages
=====
* $ portsnap fetch update
* $ portupgrade -a

Upgrade all pkg packages
=====
* $ sudo pkg update && sudo pkg upgrade

Add user to sudoer
=====
* $ whereis sudo
* $ cd /usr/ports/security/sudo
* $ export BATCH=yes
* $ make install clean
* $ visudo
```sudoers
##
## User privilege specification
##
root  ALL=(ALL) ALL
joeky ALL=(ALL) ALL
```

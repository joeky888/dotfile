Ports
=====
* Login as root
* $ portsnap fetch extract # (Do this for the first time)
* Update ports tree (Login as root)
* $ portsnap fetch update
* Uninstall poarts packages
* $ whereis zsh
* $ cd /usr/ports/shells/zsh
* $ make deinstall
* Upgrade all ports packages
* $ portsnap fetch update
* $ portupgrade -a

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

Make pkg faster
=====
* $ sudoedit /etc/pkg/FreeBSD.conf
```conf
# Change url from
url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
# To
url: "pkg+http://pkg.tw.FreeBSD.org/${ABI}/latest",
```

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

Install jfbterm
=====
* $ git clone --depth 1 https://github.com/source-archive/jfbterm-FreeBSD && cd jfbterm-FreeBSD
* $ ./configure CPPFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib --prefix=/usr/local --mandir=/usr/local/man
* $ gmake && sudo gmake install

Install LXQt
=====
* Don't do it if `pkg search lxqt` failed

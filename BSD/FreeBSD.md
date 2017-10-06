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

Install jfbterm (Epic Fail!!)
=====
```sh
sudo pkg install libiconv png gnu-unifont
export CC='gcc' && export CXX='g++' # GCC
git clone --depth 1 https://github.com/j16180339887/jfbterm-FreeBSD && cd jfbterm-FreeBSD
rm configure && autoreconf -ifv
./configure CPPFLAGS=-I/usr/local/include CFLAGS=-DLIBICONV_PLUG LDFLAGS=-L/usr/local/lib LIBS=-liconv --prefix=/usr/local --mandir=/usr/local/man
gmake && sudo gmake install
sudo cp /usr/local/etc/jfbterm.conf.sample /usr/local/etc/jfbterm.conf
sudo mkdir -p /usr/local/share/fonts/bitmap/
sudo cp fonts/*.pcf.gz /usr/local/share/fonts/bitmap/
sudo mkfontscale /usr/local/share/fonts/bitmap/
sudo mkfontdir /usr/local/share/fonts/bitmap/
sudo fc-cache -fv
```

Install LXQt
=====
* Don't do it if `pkg search lxqt` failed

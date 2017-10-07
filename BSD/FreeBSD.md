Install
=====
* dvd1.iso is better than disc1.iso
* Boot the iso file with UEFI, not BIOS
* Hostname must be filled
* Use AutoZFS for partition

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
Rebuild Kernel
=====
* Rebuild Kernel
* $ aria2c ftp://ftp.tw.freebsd.org/pub/FreeBSD/releases/amd64/MY-FREEBSD-RELEASE/src.txz
* $ sudo tar -C / -xzvf src.txz
* $ sudoedit /usr/src/sys/amd64/conf/GENERIC
```conf
options VESA
options SC_PIXEL_MODE
```
* $ cd /usr/src
* $ sudo make -j4 buildkernel && sudo make installkernel

Install yaft (yet another framebuffer terminal)
=====
```sh
sudoedit /boot/loader.conf # Remove `kern.vty=vt` , Add `kern.vty=sc`
sudo kldload vesa # If failed, try to boot with BIOS instead of UEFI
vidcontrol -i mode
vidcontrol MODE_279
echo "allscreens_flags=\"MODE_279\"" >> /etc/rc.conf
kbdcontrol -r fast
sudo memcontrol set -b 0xe0000000 -l 0x10000000 -o SVGA write-combine
git clone --depth 1 https://github.com/uobikiemukot/yaft.git
make
sudo pkg install ncurses
sudo make install
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
sudo cat termcap.jfbterm >> /usr/share/misc/termcap
sudo cap_mkdb /usr/share/misc/termcap
```

Install LXQt
=====
* Don't do it if `pkg search lxqt` failed

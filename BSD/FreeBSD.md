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
Defaults timestamp_timeout=-1
```

Display CJK font (Kernel rebuilding required)
=====
* Rebuild Kernel, then do the following things
* $ sudoedit /boot/loader.conf
```conf
hw.vga.textmode=0
kern.vty="vt"
```
* Download GNU Unifont font (HEX format)
* $ aria2c http://unifoundry.com/pub/unifont-10.0.06/font-builds/unifont_sample-10.0.06.hex.gz
* $ vtfontcvt unifont.hex jj.fnt
* $ sudo cp jj.fnt /usr/share/vt/fonts/
* $ sudoedit /etc/rc.conf
```conf
font8x16="jj"
allscreens_flags="-f /usr/share/vt/fonts/jj.fnt" # Tmux could causes problems
```
* $ sudo reboot
* $ vidcontrol -f jj.fnt #Tmux could causes problems, start with zsh/bash without tmux
* $ sudoedit /etc/rc.conf

Large console font size
=====
* $ vidcontrol -f gallant

Rebuild Kernel
=====
* $ aria2c ftp://ftp.tw.freebsd.org/pub/FreeBSD/releases/amd64/MY-FREEBSD-RELEASE/src.txz
* $ sudo rm -rf /usr/src
* $ sudo tar -C / -xzvf src.txz
* $ sudoedit /usr/src/sys/amd64/conf/GENERIC
```conf
options TERMINAL_NORM_ATTR=(FG_WHITE|BG_BLACK) # Normal output color
options TERMINAL_KERN_ATTR=(FG_LIGHTCYAN|BG_BLACK) # Kernel output color
options VESA
device vt
device vt_vga
# Comment out these lines, which against the vt option
#device         sc
#options        SC_PIXEL_MODE   # add support for the raster text mode
#device         vga             # VGA video card driver
```
* $ sudoedit /usr/src/sys/dev/vt/colors/vt_termcolors.c
```c
static const struct {
    unsigned char r;    /* Red percentage value. */
    unsigned char g;    /* Green percentage value. */
    unsigned char b;    /* Blue percentage value. */
} color_def[16] = {
    {0,      0,      0},    /* black */         /* #000000 */
    {69,     0,      0},    /* dark red */      /* #AF0000 */
    {0,     69,      0},    /* dark green */    /* #00AF00 */
    {100,  100,      0},    /* dark yellow */   /* #ffff00 */
    {0,      0,     69},    /* dark blue */     /* #0000AF */
    {68,    51,    100},    /* dark magenta */  /* #ae81ff */
    {63,    94,     89},    /* dark cyan */     /* #a1efe4 */
    {97,    97,     95},    /* light gray */    /* #f8f8f2 */

    {49,    56,     57},    /* dark gray */     /* #7E8E91 */
    {98,    15,     45},    /* light red */     /* #f92672 */
    {65,    89,     18},    /* light green */   /* #a6e22e */
    {96,    75,     46},    /* light yellow */  /* #f4bf75 */
    {40,    85,     94},    /* light blue */    /* #66d9ef */
    {68,    51,    100},    /* light magenta */ /* #ae81ff */
    {63,    94,     89},    /* light cyan */    /* #a1efe4 */
    {100,   100,   100},    /* white */         /* #ffffff */
};
```
* $ cd /usr/src
* $ sudo make -j4 buildkernel && sudo make installkernel

Install yaft (yet another framebuffer terminal) [Epic Fail!!]
=====
```sh
sudoedit /boot/loader.conf # Remove `kern.vty=vt` , Add `kern.vty=sc`
sudo kldload vesa # If failed, try to boot with BIOS instead of UEFI
# sudo echo "vesa_load=\"YES\"" >> /boot/loader.conf
vidcontrol -i mode
vidcontrol MODE_279
echo "allscreens_flags=\"MODE_279\"" >> /etc/rc.conf
kbdcontrol -r fast
sudo memcontrol set -b 0xe0000000 -l 0x10000000 -o SVGA write-combine
git clone --depth 1 https://github.com/uobikiemukot/yaft.git
sudo pkg install ncurses
make
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

Install LXDE
=====
* $ sudo pkg install lxde-meta lxde-common openbox xorg
* $ echo 'exec startlxde' > ~/.xinitrc
* $ sudoedit /etc/rc.conf
```conf
dbus_enable="YES"
slim_enable="YES"
hald_enable="YES"
```
* $ sudoedit /usr/local/etc/X11/xorg.conf.d/driver-scfb.conf
```conf
Section "Device"
    Identifier    "Card0"
    Driver        "scfb"
EndSection
```
* $ startx

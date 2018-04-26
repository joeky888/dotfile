Compile
=====
* $ sudo apt install -y gcc build-essential libncurses5-dev libpam0g-dev libsepol1-dev libselinux1-dev
* $ make defconfig && make clean && make LDFLAGS=-static

Shell
=====
* $ ./busybox ash

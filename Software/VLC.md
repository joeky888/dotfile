Performance
=====
* Tools -> Preferences -> All -> Input / Codecs -> File Caching -> 30000ms
* Copy vlc.exe to vlc-gpu.exe -> open NVIDIA setting add vlc-gpu.exe to GPU list

Compile VLC (Ubuntu)
=====
* Read FFmpeg.md and install ffmpeg
* Install -> liba52-0.7.4-dev libaa1-dev libasound2-dev libass-dev \
                libavahi-client-dev libcaca-dev libcairo2-dev libcddb2-dev libcdio-dev libdca-dev \
                libdvbpsi-dev libebml-dev libfaad-dev libflac-dev libfreetype6-dev libfribidi-dev \
                libgcrypt11-dev libgl1-mesa-dev libglib2.0-0 libgnutls28-dev libid3tag0-dev \
                libjack-jackd2-dev libkate-dev liblircclient-dev liblua5.1-0-dev libmad0-dev \
                libmatroska-dev libmodplug-dev libmpcdec-dev libmpeg2-4-dev libmtp-dev \
                libncursesw5-dev libnotify-dev libogg-dev liboggkate-dev libpango1.0-dev \
                libpng12-0 libprojectm-dev libprojectm-qt-dev libproxy-dev libpulse-dev \
                libqt4-dev libraw1394-dev librsvg2-dev libschroedinger-dev libsdl-image1.2-dev \
                libsdl1.2-dev libshout3-dev libsmbclient-dev libspeex-dev libsqlite3-dev \
                libsysfs-dev libtag1-dev libtar-dev libgme-dev libtheora-dev libtool \
                libtwolame-dev libudev-dev libupnp-dev libv4l-dev libvcdinfo-dev libvorbis-dev \
                libva-dev libvpx-dev libx11-dev libx11-xcb-dev libxcb-composite0-dev libx265-dev \
                libxcb-keysyms1-dev libxcb-randr0-dev libxcb-shm0-dev libxcb-xv0-dev libxcb-xvmc0-dev \
                libxcb1-dev libxext-dev libxml2-dev libxpm-dev libxt-dev libxv-dev libzvbi-dev lua5.1 \
                qt4-qtconfig libspeexdsp-dev libsamplerate0-dev libvdpau-dev libxpm-dev libxinerama-dev \
                libtar-dev libgtk2.0-dev libdc1394-22-dev libopus-dev libmpg123-dev protobuf-c-compiler \
                libdvdnav-dev libdvdnav4 libdvdread-dev libdvdread4 libalsa-ocaml-dev
* $ git clone --depth=1 git://git.videolan.org/vlc.git
* $ ./configure

sudo apt-get -y install build-essential git-core checkinstall \
automake yasm cmake && mkdir -pv $HOME/vlc_build

sudo apt-get -y install liba52-0.7.4-dev libaa1-dev libasound2-dev libass-dev \
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
libdvdnav-dev libdvdnav4 libdvdread-dev libdvdread4 libfdk-aac-dev

sudo apt-get install libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg

if [ "$(uname -m)" = "x86_64" ]; then
  ARCHOPTS="--enable-pic"
 else
  ARCHOPTS=""
fi && \
cd $HOME/vlc_build && \
git clone git://git.videolan.org/x264.git --depth 1 && \
cd x264 && \
./configure --prefix=$HOME/vlc_build/vlcdeps/usr \
            --enable-static \
            --disable-cli \
            $ARCHOPTS && \
make && make install

sudo apt-get -y install libmp3lame-dev zlib1g-dev libgsm1-dev libopenjpeg-dev && \
cd $HOME/vlc_build && \
git clone --depth=1 git://source.ffmpeg.org/ffmpeg && cd ffmpeg && \
if [ "$(uname -m)" = "x86_64" ]; then
  ARCHOPTS="--enable-pic"
 else
  ARCHOPTS=""
fi && \
CPPFLAGS="-I$HOME/vlc_build/vlcdeps/usr/include" \
LDFLAGS="-L$HOME/vlc_build/vlcdeps/usr/lib" \
PKG_CONFIG_PATH="$HOME/vlc_build/vlcdeps/usr/lib/pkgconfig" \
./configure --prefix=$HOME/vlc_build/vlcdeps/usr \
         $ARCHOPTS \
    --disable-doc \
    --disable-encoder=vorbis \
    --disable-decoder=opus \
    --enable-libgsm \
    --enable-libopenjpeg \
    --disable-debug \
    --disable-avdevice \
    --disable-devices \
    --disable-avfilter \
    --disable-filters \
    --disable-protocol=concat \
    --disable-bsfs \
    --disable-bzlib \
    --disable-avresample \
    --disable-swresample \
    --disable-iconv \
    --enable-libfdk-aac \
    --enable-libx265 \
    --enable-libmp3lame \
    --enable-libvpx \
    --disable-decoder=libvpx_vp8 \
    --disable-decoder=libvpx_vp9 \
    --target-os=linux \
    --enable-static \
    --disable-shared \
    --enable-gpl \
    --enable-nonfree && \
make -j 8 && make install-libs install-headers && make distclean

sed -i_bak 's#Libs: -L${libdir}  -lavutil -lm#\
Libs: -L${libdir}  -lavutil -lm  -lX11 -lm  -lvdpau -lva -lva-drm -lva-x11#' \
~/vlc_build/vlcdeps/usr/lib/pkgconfig/libavutil.pc

cd $HOME/vlc_build && git clone git://git.videolan.org/vlc.git --depth 1 && \
cd $HOME/vlc_build/vlc && ./bootstrap && \
CPPFLAGS="-I$HOME/vlc_build/vlcdeps/usr/include" \
LDFLAGS="-L$HOME/vlc_build/vlcdeps/usr/lib" \
PKG_CONFIG_PATH="$HOME/vlc_build/vlcdeps/usr/lib/pkgconfig" \
./configure --prefix=/usr/local && \
make -j 8 && \
mkdir -vp doc-pak && cp -v AUTHORS COPYING INSTALL NEWS README THANKS doc-pak && \
sudo checkinstall --pakdir "$HOME/vlc_build" --backup=no --deldoc=yes --pkgname \
                  --fstrans=no --deldesc=yes --delspec=yes --default && \
make distclean && sudo ldconfig

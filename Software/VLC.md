Performance
=====
* Tools -> Preferences -> All -> Input / Codecs -> File Caching -> 30000ms
* Copy vlc.exe to vlc-gpu.exe -> open NVIDIA setting add vlc-gpu.exe to GPU list

Compile VLC (Ubuntu)
=====
* Read FFmpeg.md and install ffmpeg
* Install -> lua5.1 liblua5.1-0-dev liba52-0.7.4-dev libxcb1-dev libxcb-shm0-dev libxcb-composite0-dev libxcb-xv0-dev libalsa-ocaml-dev libalsa-ocaml-dev
* $ git clone --depth=1 git://git.videolan.org/vlc.git
* $ ./configure

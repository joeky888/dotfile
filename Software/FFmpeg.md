Merge 1.mp4 2.mp4 3.mp4 to merge.mp4
=====
* $ cat list.txt
* file '/path/to/1.mp4'
* file '/path/to/2.mp4'
* file '/path/to/3.mp4'
* $ ffmpeg -y -f concat -safe 0 -i list.txt -c copy merge.mp4

Embed sub.srt to input.mp4
=====
* $ ffmpeg -i sub.srt sub.ass
* Then edit font and fontsize in sub.ass
* $ ffmpeg -i input.mp4 -vf ass=sub.ass output.mp4

Swap audio track order (1, 2 -> 2, 1)
=====
* $ ffmpeg -i input.mkv -map 0:0 -map 0:2 -map 0:1 -c copy output.mkv
* The first part before the colon is the input ID. Since we only have one input, it's 0
* The second part is the ID of the input stream. 0 will probably be the video track, and 1 and 2 will be your audio tracks.
* The order of the -map options determines the order of the streams in the output file.

Extract part of a video
=====
* ffmpeg -i input_file -ss start_seconds -t duration_seconds output_file
* extract 5 seconds start with 00:00:30
* $ ffmpeg -i orginalfile -ss 00:00:30 -t 00:00:05 newfile

Speed up / Slow down a video
=====
* 2x speed
* $ ffmpeg -i input.mp4 -filter:v "setpts=0.5*PTS" -filter:a "atempo=2.0" output.mp4
* 1.25x speed
* $ ffmpeg -i input.mp4 -filter:v "setpts=0.8*PTS" -filter:a "atempo=1.25" output.mp4

Set default audio track
=====
* Set second audio track as default
* $ ffmpeg -i input.mkv -disposition:a:1 default output.mkv
* Set first audio track as default
* $ ffmpeg -i input.mkv -disposition:a:0 default output.mkv

Set default subtitle track
=====
* Set second subtitle track as default
* $ ffmpeg -i input.mkv -disposition:s:1 default output.mkv
* Set first subtitle track as default
* $ ffmpeg -i input.mkv -disposition:s:0 default output.mkv

Compile ffmpeg on Cygwin
=====
* Install -> libtool yasm yasm-devel binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel
* Install libmp3
    * Download http://cas.ee.ic.ac.uk/people/dt10/teaching/2013/hpce/cw2/lame-3.99.5-alt.tar.gz
    * $ ./configure --enable-static --disable-shared
    * $ make -j 8 && make install
* Install libaac
    * $ git clone --depth=1 https://github.com/mstorsjo/fdk-aac.git
    * $ ./autogen.sh
    * $ ./configure --enable-static --disable-shared
    * $ make -j 8 && make install
* Install libh264
    * $ git clone --depth=1 git://git.videolan.org/x264.git
    * $ ./configure --enable-static --enable-shared
    * $ make -j 8 && make install
* Install libh265
    * $ Download https://bitbucket.org/multicoreware/x265/downloads
    * $ cd build/linux
    * $ cmake -G "Unix Makefiles" -DENABLE_SHARED:bool=off ../../source
    * $ make -j 8 && make install
* Install ffmpeg
    * $ git clone --depth=1 git://source.ffmpeg.org/ffmpeg
    * $ ./configure --pkg-config-flags="--static" --extra-ldflags="-L/usr/local/lib" --disable-ffplay --disable-ffprobe --disable-ffserver --disable-debug --disable-doc --enable-version3 --enable-static --disable-shared --enable-gpl --enable-nonfree --enable-libx264 --enable-libx265 --enable-libmp3lame --enable-libfdk-aac --enable-fontconfig --enable-iconv --enable-libass --enable-libfreetype --enable-libopenjpeg --enable-libopus --enable-libvorbis --enable-libvpx --enable-libwebp
    * $ make -j 8 && make install
* If ./configure failed
    * check the error message at end of the file 'config.log'
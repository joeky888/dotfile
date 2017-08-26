Merge 1.mp4 2.mp4 3.mp4 to merge.mp4
=====
* $ cat list.txt
* file '/path/to/1.mp4'
* file '/path/to/2.mp4'
* file '/path/to/3.mp4'
* $ ffmpeg -y -f concat -safe 0 -i list.txt -c copy merge.mp4

Embed sub.srt to input.mp4 (hardsub)
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
* ffmpeg -i inputfile -ss startseconds -t durationseconds outputfile
* Extract 5 seconds start with 00:00:30
* Time format HH:MM:SS.xxx where xxx are milliseconds
* $ ffmpeg -i orginalfile -ss 00:00:30.000 -t 00:00:05.000 newfile.mp4
* Extract video from 00:00:30 to 00:00:40
* $ ffmpeg -i orginalfile -ss 00:00:30.000 -to 00:00:40.000 newfile.mp4
* Extract video from 00:00:30 to the end
* $ ffmpeg -i orginalfile -ss 00:00:30.000 newfile.mp4

Changing the resolution
======
* $ ffmpeg -i input.mkv -s 720x480 -c:a copy output.mkv
* Or
* $ ffmpeg -i input.mkv -vf scale=720x480 -c:a copy output.mkv

Delay / Hasten audio track
=====
* Time format HH:MM:SS.xxx where xxx are milliseconds
* Delay 5 Second
* $ ffmpeg -i input.mp4 -itsoffset 00:00:05.000 -i input.mp4 -map 0:v -map 1:a output.mp4
* Hasten 5 Second
* $ ffmpeg -i input.mp4 -itsoffset -00:00:05.000 -i input.mp4 -map 0:v -map 1:a output.mp4

Volumn up/down of a video
=====
* Volumn up
* ffmpeg -i input.mp4 -vcodec copy -af "volume=10dB" output.mp4
* Volumn down
* ffmpeg -i input.mp4 -vcodec copy -af "volume=-10dB" output.mp4

Show progress bar
=====
```sh
pv input.mkv | ffmpeg -i pipe:0 -v warning {arguments}
```

Set default audio track
=====
* Set second audio track as default
* $ ffmpeg -i input.mkv -disposition:a:1 forced output.mkv
* Set first audio track as default
* $ ffmpeg -i input.mkv -disposition:a:0 forced output.mkv

Set default subtitle track
=====
* Set second subtitle track as default
* $ ffmpeg -i input.mkv -disposition:s:1 forced output.mkv
* Set first subtitle track as default
* $ ffmpeg -i input.mkv -disposition:s:0 forced output.mkv

Add subtitle track to .mkv (softsub)
=====
* 0:0 means first video track
* 0:1 means first audio track
* 1:0 means sub.srt first subtitle track
* $ ffmpeg -i input.mkv -i sub.srt -map 0:0 -map 0:1 -map 1:0 -c copy output.mkv

Set video title
=====
* Clear title
* $ ffmpeg -i input.mkv -metadata title="" -c copy -map 0 output.mkv
* Set title to "國語片"
* $ ffmpeg -i input.mkv -metadata title="國語片" -c copy -map 0 output.mkv

Set audio track title
=====
* Set first track title to "國語"
* $ ffmpeg -i input.mp4 -map 0 -metadata:s:a:0 title="國語" output.mp4
* Set second track title to "粵語"
* $ ffmpeg -i input.mp4 -map 0 -metadata:s:a:1 title="粵語" output.mp4

Extract subtitle
=====
* $ ffmpeg -i Movie.mkv -map 0:s:0 subs.srt

Copy encoding if convert coding is not available
=====
* Video
* $ ffmpeg -i input.mkv -c:v copy output.mkv
* Audio
* $ ffmpeg -i input.mkv -c:a copy output.mkv
* Subtitle
* $ ffmpeg -i input.mkv -c:s copy output.mkv

Left channel to 1st audio track, right channel to 2nd audio track
=====
* The best way to go is spliting left and right channels into 2 files
* The example rmvb 0:0 is audio track and 0:1 is video track
* Get left 國語
```sh
find . -name '*.rmvb' -exec sh -c 'ffmpeg -i "$0" -c:a libopus -map 0:0 -map_channel 0.0.0 -map_channel 0.0.0 "${0%.rmvb}l.opus" ' {} \;
```
* Get Right 韓語
```sh
find . -name '*.rmvb' -exec sh -c 'ffmpeg -i "$0" -c:a libopus -map 0:0 -map_channel 0.0.0 -map_channel 0.0.0 "${0%.rmvb}l.opus" ' {} \;
```
* Merge \*.opus and video track into mkv
```sh
find . -name '*.rmvb' -exec sh -c 'ffmpeg -i "$0" -i "${0%.rmvb}l.opus" -i "${0%.rmvb}r.opus" -map 0:1 -map 1:0 -map 2:0 -metadata:s:a:0 title="國語" -metadata:s:a:1 title="Korean" -disposition:a:0 forced -c:a copy -y "${0%.rmvb}.mkv" ' {} \;
```

Attached font file to .mkv
=====
* Suppose there is a file input.mkv with a video track, an audio track and a subtitle track
* Stream 0 of the file is video, stream 1 is audio, stream 2 is subtitle
* So the font file should be attacked to stream 3, and the flag is -metadata:s:3
* $ ffmpeg -i input.mkv -attach DejaVuSans.ttf -metadata:s:3 mimetype=application/x-truetype-font out.mkv

Remove all audio tracks
=====
* $ ffmpeg -i input -an ouput
* Remove all video tracks
* $ ffmpeg -i input -vn ouput
* Remove all subtitle tracks
* $ ffmpeg -i input -sn ouput

Show all codes
=====
* $ ffmpeg -codecs
* Or
* $ ffmpeg -formats

Show media info
=====
* $ ffprobe input.mkv
* Or
* $ ffprobe -i input.mkv

Convert a folder
=====
* opus to mp3
* $ mkdir -p ../ffconvert && find . -iname "\*.opus" -exec sh -c 'chmod 777 "$0" && ffmpeg -i "$0" ../ffconvert/"${0/.opus}.mp3"' {} \;

Speed up / Slow down a video
=====
* 2x speed
```sh
ffmpeg -i input.mp4 -filter:v "setpts=0.5*PTS" -filter:a "atempo=2.0" output.mp4
```
* 1.5x speed
```sh
ffmpeg -i input.mp4 -filter:v "setpts=0.666666*PTS" -filter:a "atempo=1.5" output.mp4
```
* 1.25x speed
```sh
ffmpeg -i input.mp4 -filter:v "setpts=0.8*PTS" -filter:a "atempo=1.25" output.mp4
```

Merge VTS-01-1.VOB VTS-01-2.VOB VTS-01-3.VOB to VTS-01.VOB
=====
* $ cat VTS-01-\*.VOB > VTS-01.VOB

Compile ffmpeg on Cygwin
=====
* Install (Cygwin) -> libtool yasm yasm-devel nasm binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel
* Install libmp3
```sh
aria2c https://github.com/j16180339887/lame/archive/master.zip && 7z x lame-master.zip && cd lame-master
./configure --enable-static --disable-shared && make -j 8 && make install
ffmpeg -i input -c:a libmp3lame output
```

* Install libaac
```sh
aria2c https://github.com/mstorsjo/fdk-aac/archive/master.zip && 7z x fdk-aac-master.zip && cd fdk-aac-master
./autogen.sh && ./configure --enable-static --disable-shared && make -j 8 && make install
ffmpeg -i input -c:a libfdk_aac output
```

* Install libh264
```sh
aria2c ftp://ftp.videolan.org/pub/x264/snapshots/last_x264.tar.bz2 && 7z x last_x264.tar.bz2 && 7z x last_x264.tar && cd x264*
./configure --enable-static && make -j 8 && make install
# If there is an error about "HMODULE" when compiling, just add "#include <windows.h>" to file "extras/avisynth_c.h"
ffmpeg -i input -c:v libx264 output
```

* Install libh265
```sh
# Download https://bitbucket.org/multicoreware/x265/downloads
aria2c https://github.com/videolan/x265/archive/master.zip && 7z x x265-master.zip && cd x265-master
cd build/linux && cmake -G "Unix Makefiles" -DENABLE_SHARED:bool=off ../../source && make -j 8 && make install
ffmpeg -i input -c:v libx265 output
```

* Install ffmpeg
```sh
aria2c https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && 7z x ffmpeg-snapshot.tar.bz2 && 7z x ffmpeg-snapshot.tar && cd ffmpeg
./configure --pkg-config-flags="--static" --extra-ldflags="-L/usr/local/lib" --disable-ffplay --disable-ffserver --disable-debug --enable-version3 --enable-static --disable-shared --enable-gpl --enable-nonfree --enable-libx264 --enable-libx265 --enable-libmp3lame --enable-libfdk-aac --enable-fontconfig --enable-iconv --enable-libass --enable-libfreetype --enable-libopenjpeg --enable-libopus --enable-libvorbis --enable-libvpx --enable-libwebp && make -j 8 && make install
```

* If ./configure failed
    * check the error message at end of the file 'config.log'

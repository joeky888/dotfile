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
* ffmpeg -i input_file -ss start_seconds -t duration_seconds -c copy output_file
* extract 5 seconds start with 00:00:30
* $ ffmpeg -i orginalfile -ss 00:00:30 -t 00:00:05 -c copy newfile

Speed up / Slow down a video
=====
* 2x speed
* $ ffmpeg -i input.mp4 -filter:v "setpts=0.5*PTS" -filter:a "atempo=2.0" output.mp4
* 1.25x speed
* $ ffmpeg -i input.mp4 -filter:v "setpts=0.8*PTS" -filter:a "atempo=1.25" output.mp4
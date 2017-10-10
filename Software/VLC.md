Performance
=====
* Tools -> Preferences -> All -> Input / Codecs -> File Caching -> 30000ms
* Tools -> Preferences -> All -> Input / Codecs -> Video codecs -> FFmpeg -> Skip the loop filter for H.264 decoding -> All
* Tools -> Preferences -> All -> Interface -> Main interfaces -> Qt -> Maximum Volume displayed > 300%
* Tools -> Preferences -> All -> Interface -> Hotkeys settings
    * Very short backwards jump -> Left
    * Very short forward jump -> Right
    * Volumn up -> Up
    * Volumn down -> Down
    * Very short jump length -> 5 seconds
    * Medium jump length -> 25 seconds
* Copy vlc.exe to vlc-gpu.exe -> open NVIDIA setting and add vlc-gpu.exe to GPU list

Subtitle
=====
* Tools -> Preferences -> Subtitles/OSD
    * Show media title on video start -> uncheck
    * Default encoding -> Universal(UTF-8)
    * Font -> use wps office font

Android
=====
* Settings -> Play videos in background -> check
* Settings -> Interface -> Enable the black theme -> check

Crashes on some videos
=====
* Fix the video so that let VLC ignores the errors
```sh
ffmpeg -err_detect ignore_err -i video.mkv -c copy video_fixed.mkv
```

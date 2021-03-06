Performance
=====
* Tools -> Preferences -> All -> Input / Codecs -> File Caching -> 59999ms
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

With GPU supported on Windows
=====
```sh
Copy-Item "$env:PROGRAMFILES\\VideoLAN\\VLC\\vlc.exe" -Destination "$env:PROGRAMFILES\\VideoLAN\\VLC\\vlc-gpu.exe"
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\\Desktop\\VLC.lnk")
$Shortcut.TargetPath = "$env:PROGRAMFILES\\VideoLAN\\VLC\\vlc-gpu.exe"
$Shortcut.Save()
Remove-Item "$env:PROGRAMFILES\\VideoLAN\\VLC\\vlc-gpu.exe"
New-Item -ItemType SymbolicLink -Path "$env:PROGRAMFILES\\VideoLAN\\VLC" -Name "vlc-gpu.exe" -Value "$env:PROGRAMFILES\\VideoLAN\\VLC\\vlc.exe"
```

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

Convert disc cda to mp3
=====
```dosbatch
:: Save it to convert.bat
:: Change "D:" to somewhere else
:: Output to "%USERPROFILE%\Desktop\mp3"
@ECHO OFF
setlocal ENABLEDELAYEDEXPANSION
SET /a x=0

mkdir "%USERPROFILE%\Desktop\mp3"

FOR /R D:\ %%G IN (*.cda) DO (CALL :SUB_VLC "%%G")
pause
GOTO :eof

:SUB_VLC
call SET /a x=x+1
ECHO Transcoding %1
REM Here's where the actual transcoding/conversion happens. The next line
REM fires off a command to VLC.exe with the relevant arguments:
CALL "C:\Program Files\VideoLAN\VLC\vlc" -I http cdda:///D:/ --cdda-track=!x! :sout=#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100}:std{access="file",mux=raw,dst="%USERPROFILE%\Desktop\mp3\Track!x!.mp3"} vlc://quit
:eof
```

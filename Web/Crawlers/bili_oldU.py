#!/usr/bin/env python3

import subprocess, sys, os, codecs

Error_List = []

Error_List.append( "https://www.bilibili.com/video/av7931969/?p=1" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=2" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=3" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=4" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=5" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=6" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=7" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=8" )
Error_List.append( "https://www.bilibili.com/video/av7931969/?p=9" )

DOWNLOADER="youtube-dl"
DOWNLOADER_ARGS='--external-downloader aria2c --external-downloader-args "-c -s16 -k1M -x16 -j16"'

# Remove duplicates
Error_List = list(set(Error_List))

for url in Error_List:
    cmd = DOWNLOADER + " " + DOWNLOADER_ARGS + " " + url
    print(cmd)
    if os.system(cmd) != 0:
        print("Download Error: " + url)
        Error_List.append(url)

# Retry
while len(Error_List) != 0:
    NewError_List = []
    for url in Error_List:
        cmd = DOWNLOADER + " " + DOWNLOADER_ARGS + " " + url
        print(cmd)
        if os.system(cmd) != 0:
            print("Download Error: " + url)
            NewError_List.append(i)
    Error_List = []
    Error_List = NewError_List[:]

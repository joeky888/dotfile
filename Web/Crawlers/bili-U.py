#!/usr/bin/env python3

import subprocess, sys, os, codecs, time

Error = []
MAX_DOWNLOAD_AT_ONCE = 5
processes = []
url = []

url.append( "https://www.bilibili.com/video/av7931969/?p=1" )
url.append( "https://www.bilibili.com/video/av7931969/?p=2" )
url.append( "https://www.bilibili.com/video/av7931969/?p=3" )
url.append( "https://www.bilibili.com/video/av7931969/?p=4" )
url.append( "https://www.bilibili.com/video/av7931969/?p=5" )
url.append( "https://www.bilibili.com/video/av7931969/?p=6" )
url.append( "https://www.bilibili.com/video/av7931969/?p=7" )
url.append( "https://www.bilibili.com/video/av7931969/?p=8" )
url.append( "https://www.bilibili.com/video/av7931969/?p=9" )
url.append( "https://www.bilibili.com/video/av7931969/?p=10" )
url.append( "https://www.bilibili.com/video/av7931969/?p=11" )
url.append( "https://www.bilibili.com/video/av7931969/?p=12" )
url.append( "https://www.bilibili.com/video/av7931969/?p=13" )
url.append( "https://www.bilibili.com/video/av7931969/?p=14" )
url.append( "https://www.bilibili.com/video/av7931969/?p=15" )
url.append( "https://www.bilibili.com/video/av7931969/?p=16" )
url.append( "https://www.bilibili.com/video/av7931969/?p=17" )
url.append( "https://www.bilibili.com/video/av7931969/?p=18" )
url.append( "https://www.bilibili.com/video/av7931969/?p=19" )
url.append( "https://www.bilibili.com/video/av7931969/?p=20" )

for idx, u in enumerate(url):
    processes.append( [subprocess.Popen([ "you-get", u, "-o", str(idx) ]), u, idx] )
    while len(processes) >= MAX_DOWNLOAD_AT_ONCE:
        time.sleep(.1)
        for i, p in enumerate(processes):
            # if p[0].returncode == None, it means that downloading is not finished
            if p[0].poll() == 0:
                # Succeed
                processes.pop(i)
            elif p[0].returncode != None:
                # Failed
                processes.pop(i)
                Error.append( [subprocess.Popen([ "you-get", p[1], "-o", str(p[2]) ]), p[1], p[2]] )
                time.sleep(.1)
        processes.extend(Error)
        Error = []

# Execute this bash command
# $ find . -name '*' -type f -exec mv {} ./ \; && find . -type d -empty -delete

# Or the Powershell Command
# $ Get-ChildItem -Path . -Recurse -File | Move-Item -Force -Destination . ; Get-ChildItem -Path . -Recurse -Directory | Remove-Item

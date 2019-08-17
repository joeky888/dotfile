#!/usr/bin/env python3

import subprocess, sys, os, codecs, time

Error = []
MAX_DOWNLOAD_AT_ONCE = 16
processes = []
url = []

for u in sys.argv[1:]:
    url.append(u)

# url.append( "https://www.bilibili.com/video/av7931969/?p=1" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=2" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=3" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=4" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=5" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=6" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=7" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=8" )
# url.append( "https://www.bilibili.com/video/av7931969/?p=9" )

# Remove duplicates
url = list(set(url))

class Video():
    def __init__(self, url):
        self.url     = url
        self.process = subprocess.Popen( self.getJob() )
    def getJob(self):
        return ["annie", self.url]

for idx, u in enumerate(url):
    processes.append(
        Video(u)
    )
    while len(processes) >= MAX_DOWNLOAD_AT_ONCE or (idx == len(url)-1 and len(processes) > 0):
        time.sleep(.1)
        for i, video in enumerate(processes):
            # if p[0].returncode == None, it means that downloading is not finished
            if video.process.poll() == 0:
                # Succeed
                processes.pop(i)
            elif video.process.returncode != None:
                # Failed
                processes.pop(i)
                Error.append( Video(video.url) )
                time.sleep(.1)
        processes.extend(Error)
        Error = []

# Execute this bash command
# $ find . -name '*' -type f -exec mv {} ./ \; && find . -type d -empty -delete

# Or the Powershell Command
# $ Get-ChildItem -Path . -Recurse -File | Move-Item -Force -Destination . ; Get-ChildItem -Path . -Recurse -Directory | Remove-Item

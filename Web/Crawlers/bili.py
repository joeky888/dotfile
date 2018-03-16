#!/usr/bin/env python3

import subprocess, sys, os, codecs, time

Error = []
MAX_DOWNLOAD_AT_ONCE = 16
processes = []
url = "https://www.bilibili.com/video/av7931969/?p="
start = 1
end   = 140

for i in range(start, end + 1):
    vid = str(i)
    processes.append( [subprocess.Popen(["you-get", url + vid, "-O", vid, "-o", vid]), i] )
    while len(processes) >= MAX_DOWNLOAD_AT_ONCE:
        time.sleep(.1)
        for idx, p in enumerate(processes):
            # if p[0].returncode == None, it means that downloading is not finished
            if p[0].poll() == 0:
                # Succeed
                processes.pop(idx)
            elif p[0].returncode != None:
                # Failed
                processes.pop(idx)
                vidp = str(p[1])
                Error.append( [subprocess.Popen(["you-get", url + vidp, "-O", vidp, "-o", vidp]), p[1]] )
                time.sleep(.1)
        processes.extend(Error)
        Error = []

# Execute this bash command
# $ find . -name '*' -type f -exec mv {} ./ \; && find . -type d -empty -delete

# Or the Powershell Command
# $ Get-ChildItem -Path . -Recurse -File | Move-Item -Force -Destination . ; Get-ChildItem -Path . -Recurse -Directory | Remove-Item

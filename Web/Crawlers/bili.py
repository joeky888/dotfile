#!/usr/bin/env python3

import subprocess, sys, os, codecs, time

Error_List = []
MAX_DOWNLOAD_AT_ONCE = 10
processes = set()
url = "https://www.bilibili.com/video/av8927491/?p="
start = 1
end   = 25

for i in range(start, end+1):
    processes.add( subprocess.Popen(["you-get", url + str(i), "-O", str(i), "-o", str(i)]) )
    while len(processes) >= MAX_DOWNLOAD_AT_ONCE:
        time.sleep(.1)
        processes.difference_update([
            p for p in processes if p.poll() is not None])

# Execute this command
# $ find . -name '*' -type f -exec mv {} ./ \;

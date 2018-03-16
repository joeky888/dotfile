#!/usr/bin/env python3

import subprocess, sys, os, codecs, time

MAX_DOWNLOAD_AT_ONCE = 10
processes = []
url = "https://www.bilibili.com/video/av7931969/?p="
start = 1
end   = 140

for i in range(start, end + 1):
    processes.append( subprocess.Popen(["you-get", url + str(i), "-O", str(i), "-o", str(i)]) )
    while len(processes) >= MAX_DOWNLOAD_AT_ONCE:
        time.sleep(.1)
        for j in range(len(processes)-1, -1, -1):
            if processes[j].poll() == 0:
                # Succeed
                processes.pop(j)
            elif processes[j].returncode != None:
                # Failed
                processes.pop(j)
                processes.append( subprocess.Popen(["you-get", url + str(j), "-O", str(j), "-o", str(j)]) )

# Execute this command
# $ find . -name '*' -type f -exec mv {} ./ \;

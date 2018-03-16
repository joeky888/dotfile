#!/usr/bin/env python3

import subprocess, sys, os, codecs, time

Error_List = []
MAX_DOWNLOAD_AT_ONCE = 10
processes = []
url = "https://www.bilibili.com/video/av8927491/?p="
start = 1
end   = 25

for i in range(start, end + 1):
    processes.append( subprocess.Popen(["you-get", url + str(i), "-O", str(i), "-o", str(i)]) )
    while len(processes) >= MAX_DOWNLOAD_AT_ONCE:
        time.sleep(.1)
        for i in range(len(processes)-1, -1, -1):
            if processes[i].poll() == 0:
                processes.pop(i)
            elif processes[i].returncode:
                Error_List.append(processes.pop(i))

        processes.extend(Error_List)
        Error_List = []


# Execute this command
# $ find . -name '*' -type f -exec mv {} ./ \;


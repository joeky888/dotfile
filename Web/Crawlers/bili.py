#!/usr/bin/env python3

# $ ./Download.py

import subprocess, sys, os, codecs

Error_List = []
url = "https://www.bilibili.com/video/av8927491/#page="
start = 1
end   = 25

for i in range(start, end+1):
    cmd = "you-get " + url + str(i) + " -O " + str(i)
    print(cmd)
    if os.system(cmd) != 0:
        print("Download Error: " + str(i))
        Error_List.append(i)

# Retry
while len(Error_List) != 0:
    NewError_List = []
    for i in Error_List:
        cmd = "you-get " + url + str(i) + " -O " + str(i)
        print(cmd)
        if os.system(cmd) != 0:
            print("Download Error: " + str(i))
            NewError_List.append(i)
    Error_List = []
    Error_List = NewError_List[:]

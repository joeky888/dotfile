#!/usr/bin/env python3

# $ ./Download.py

import subprocess, sys, os, codecs

Error_List = []

# Retry
while True:
    NewError_List = []
    for i in range(21):
        if os.system("you-get http://www.bilibili.com/video/av9760383/#page=" + str(i)) != 0:
            print("Download Error: " + url)
            NewError_List.append(url)
    Error_List = []
    Error_List = NewError_List[:]
    if len(Error_List) != 0:
        break

#!/usr/bin/env python3

# $ ./Download.py

import subprocess, sys, os, codecs

Error_List = []
url = "https://www.bilibili.com/video/av9760383/#page="

for i in range(1, 21):
    if os.system("you-get " + url + str(i) + " -O " + str(i) + ".mp4") != 0:
        print("Download Error: " + str(i))
        Error_List.append(i)

# Retry
while len(Error_List) != 0:
    NewError_List = []
    for i in Error_List:
        if os.system("you-get " + url + str(i) + " -O " + str(i) + ".mp4") != 0:
            print("Download Error: " + str(i))
            NewError_List.append(i)
    Error_List = []
    Error_List = NewError_List[:]

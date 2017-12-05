#!/usr/bin/env python3

# $ ./Download.py

import subprocess, sys, os, codecs

Error_List = []
url = "https://www.bilibili.com/video/av9760383/#page="

for i in range(1, 21):
    if os.system("you-get " + url + str(i)) != 0:
        print("Download Error: " + url + str(i))
        Error_List.append(url + str(i))

# Retry
while len(Error_List) != 0:
    NewError_List = []
    for u in Error_List:
        if os.system("you-get " + u) != 0:
            print("Download Error: " + u)
            NewError_List.append(u)
    Error_List = []
    Error_List = NewError_List[:]

#!/usr/bin/env python3

# $ ./Download.py

import subprocess, sys, os, codecs

Error_List = []

for i in range(1, 10+1):
    url = "\"http://www.example.com/video/index_" + str(i) + ".html\""
    Error_List.append(url)

# Retry
while len(Error_List) != 0:
    NewError_List = []
    for url in Error_List:
        if os.system("you-get " + url) != 0:
            print("Download Error: " + url)
            NewError_List.append(url)
    Error_List = []
    Error_List = NewError_List[:]
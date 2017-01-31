#!/usr/bin/env python3

import subprocess, sys, os, codecs

i = 1
while i <= 75:
    while os.system("curl -LOC - http://hkdbchannel.felixwongsite.com/video/" + str(i) + ".mp4") != 8448:
        print ("curl -LOC - http://hkdbchannel.felixwongsite.com/video/" + str(i) + ".mp4")
    i+=1

#!/usr/bin/env python3

# convert wav to mp3
# $ ./FFmpegConverter.py wav mp3
# $ python3 FFmpegConverter.py wav mp3

import sys, os, codecs, time, fnmatch

if len(sys.argv) == 1:
    print("Usage: ./FFmpegConverter.py <format> <format>")
    sys.exit(0)

Files = []

for root, dirnames, filenames in os.walk("."):
    for filename in fnmatch.filter(filenames, "*." + sys.argv[1]):
        Files.append(os.path.join(root, filename))

outdir = "../" + os.path.relpath(".","..") + time.strftime("-%Y-%m-%d-%H-%M-%S") + "/"
Error_List = []

def run(commands, file):
    for cmd in commands:
        if os.system(cmd) != 0:
            print("Error: " + cmd)
            Error_List.append(file)

for file in Files:
    # ffmpeg -i "$file" "${file%.wav}".mp3
    # file = file.decode(encoding='UTF-8')
    commands = []
    target = "\"" + outdir + os.path.splitext(file)[0][2:] + "." + sys.argv[2] + "\""
    targetFolder = "\"" + os.path.dirname(outdir + file[2:]) + "\""
    file1  = "\"" + file + "1\""
    file   = "\"" + file + "\""
    
    if not os.path.isdir(targetFolder):
        os.system("mkdir -p " + targetFolder)
    
    commands.append("chmod 777 " + file)
    commands.append("ffmpeg -i " + file + " -threads 8 " + target)
    run(commands, file)

for file in Error_List:
    print("Conver Error: " + file)
#!/usr/bin/env python3

# convert wav to mp3
# $ ./FFmpegConverter.py wav mp3
# $ python3 FFmpegConverter.py wav mp3

import subprocess, sys, os, codecs, time

if len(sys.argv) == 1:
    print("Usage: ./FFmpegConverter.py <format> <format>")
    sys.exit(0)

try:
    Files = subprocess.check_output("find . -iname \"*." + sys.argv[1] + "\"", shell=True).splitlines()
except subprocess.CalledProcessError as e:
    print("command '{}' return with error (code {}): {}".format(e.cmd, e.returncode, e.output))

outdir = "../" + os.path.relpath(".","..") + time.strftime("-%Y-%m-%d-%H-%M-%S") + "/"
os.system("mkdir " + outdir)
print(outdir)
Error_List = []

def run(commands, file):
    for cmd in commands:
        if os.system(cmd) != 0:
            print("Error: " + cmd)
            Error_List.append(file)

for file in Files:
    # ffmpeg -i "$file" "${file%.wav}".mp3
    file = file.decode(encoding='UTF-8')
    commands = []
    target = "\"" + outdir + os.path.splitext(file)[0][2:] + "." + sys.argv[2] + "\""
    targetFolder = "\"" + os.path.dirname(outdir + file[2:]) + "\""
    file1  = "\"" + file + "1\""
    file   = "\"" + file + "\""
    
    if not os.path.isdir(targetFolder):
        os.system("mkdir -p " + targetFolder)
    
    commands.append("chmod 755 " + file)
    commands.append("ffmpeg -i " + file + " -threads 8 " + target)
    run(commands, file)

for file in Error_List:
    print("Conver Error: " + file)
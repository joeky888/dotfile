#!/usr/bin/env python3

# convert wav to mp3
# $ ./FFmpegConverter.py wav mp3
# $ python3 FFmpegConverter.py wav mp3

import subprocess, sys, os, codecs

if len(sys.argv) == 1:
    print("Usage: ./FFmpegConverter.py <format> <format>")
    sys.exit(0)

try:
    Files = subprocess.check_output("find . -iname \"*." + sys.argv[1] + "\"", shell=True).splitlines()
except subprocess.CalledProcessError as e:
    print("command '{}' return with error (code {}): {}".format(e.cmd, e.returncode, e.output))

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
    file1  = "\"" + file + "1\""
    target = "\"" + os.path.splitext(file)[0] + "." + sys.argv[2] + "\""
    file   = "\"" + file + "\""
    
    if sys.argv[1].lower() == sys.argv[2].lower():
        # Same type
        commands.append("chmod 755 " + file)
        commands.append("mv " + file + " " + file1)
        commands.append("ffmpeg -i " + file1 + " -threads 8 " + target)
        commands.append("rm " + file1)
        run(commands, file)
    else:
        commands.append("chmod 755 " + file)
        commands.append("ffmpeg -i " + file + " -threads 8 " + target)
        run(commands, file)

for file in Error_List:
    print("Conver Error: " + file)
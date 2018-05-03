#!/usr/bin/env python3

import subprocess, sys, os, codecs, time

url = []

url.append( "asus.com" )
url.append( "github.com" )
url.append( "google.com" )

# Remove duplicates
url = list(set(url))
success = []

for idx, u in enumerate(url):
    cmd = "ping " + "-c " + "1 " + "-W " + "1 " + u
    print(cmd)
    if os.system(cmd) == 0:
        success.append(u)


print("=========================")
print("List of available sites:")
print(success)

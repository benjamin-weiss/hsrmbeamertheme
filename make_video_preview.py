#! /usr/bin/env python

import sys
import re
from subprocess import call

if len(sys.argv) < 2:
    print("Usage: %s <presentation.tex>" % sys.argv[0])
    sys.exit(1)

onlylist = False
if "--list" in sys.argv:
    onlylist = True

video = re.compile('.*video.*{(?P<file>.*\..*?)(\?.*?(start=(?P<starttime>\d*).*)?)?}')
with open(sys.argv[1],'r') as tex:
    for line in tex.readlines():
        found = video.search(line)
        if found:
            if onlylist:
                print(found.group('file'))
                continue

            starttime = found.group('starttime')
            if starttime:
                starttime = int(starttime)
            else:
                starttime = 0
            cmd = "ffmpeg -y -i " + found.group('file') + " -r 1 -vframes 1 -ss " + str(starttime) + " " + found.group('file').split('.')[0] + "_thumb.jpg"
            print("%s starting at %d" % (found.group('file'), starttime))
            print("> " + cmd)
            call(cmd, shell=True)

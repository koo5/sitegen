#!/usr/bin/env python

import os
import time
import sys
import traceback # 4 nice errors

r = open('fileinfos', 'r')
o = r.read()
r.close()


lines = o.splitlines()
del lines[0]
del lines[0]


def decstring(string):
    asciis = string.split(",")
    res = ""
    for ascii in asciis:
	res += chr(int(ascii))
    return res


def write(name, contents):
    f = open(name, 'w')
    f.write(contents)
    f.close()
#    print name, ": ", contents




f = open('filecontents', 'r')
i = f.read()
f.close()
c = i.splitlines(True)
del c[0]
i = ''.join(c)

last = 0

for line in lines:
    name = decstring(line[1:].split(",0; ")[0])
    length = int(line.split(",0; ")[1])
    print name, length
    write(name, i[last:last + length])
    last = last + length


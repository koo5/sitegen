#!/usr/bin/env python

import os
import time
import sys
import traceback # 4 nice errors

r = open('files', 'r')
o = r.read()
r.close()


lines = o.splitlines()
del lines[0]
del lines[0]


def decstring(string):
    asciis = string.split(",")
    res = []
    for ascii in asciis:
	res.append(int(ascii))
    return res

def bin(s):
    return str(s) if s<=1 else bin(s>>1) + str(s&1)

def gluebytes(i):
    res = ""
    for pos in range(0, len(i), 2):
	res += chr(int(bin(int(i[pos])).zfill(4)+bin(int(i[pos + 1])).zfill(4), 2))

for line in lines:
    line = line[1:len(line)-4]
    #print line
    strings = line.split(",0; S")
    
    filename = gluebytes(decstring(strings[0]))
    content =  gluebytes(decstring(strings[1]))
    
    #print filename , content
    
    f = open(filename, 'w')
    f.write(content)
    f.close()
    print filename


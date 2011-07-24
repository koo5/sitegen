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
    res = ""
    for ascii in asciis:
	res += chr(int(ascii))
    return res


for line in lines:
    line = line[1:len(line)-4]
    #print line
    strings = line.split(",0; S")
    
    filename = decstring(strings[0])
    content = decstring (strings[1])
    
    #print filename , content
    
    f = open(filename, 'w')
    f.write(content)
    f.close()
    print filename


#!/usr/bin/env python

import os
import time
import sys
import traceback # 4 nice errors
import types

def request_header(f, leng, name):
    f.write("* //72B4F7AB-F525-45F0-B5C7-FF9C0D38BCD7// "+name+"\n")
    f.write("! table of "+name+" (")
    f.write(str(leng))
    f.write(")\n")

def to_inform_indexed_text(t):
    r = "S"
    for c in t:
	r += str(ord(c)) + ","
    r += "0;"
    return r

def write_inform_table_file(table, name):
    f = open(name, 'w')
    request_header(f, len(table), name)
    for val in table:
	f.write(to_inform_indexed_text(val.orig) + " " + to_inform_indexed_text(val.half1) + " " + to_inform_indexed_text(val.half2) + "\n")
    f.close()

table = []

class byte:
    orig = ""

def bin(s):
    return str(s) if s<=1 else bin(s>>1) + str(s&1)

for i in range(1, 256):
    b = byte()
    b.orig = chr(i)
    bi = bin(i).zfill(8)
    b.half1 = chr(int(bi[0:4], 2) + 1)
    b.half2 = chr(int(bi[4:8], 2) + 1)
    print b.orig, bi, bi[0:4], bi[4:8], b.half1, b.half2
    table.append(b)

write_inform_table_file(table, 'unicodehell')



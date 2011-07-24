#!/usr/bin/env python

import os
import time
import sys
import traceback # 4 nice errors

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
    for name, val in table.items():
	f.write(to_inform_indexed_text(name) + " " + to_inform_indexed_text(val) + "\n")
    f.close()

posts = dict()

for root, dirs, files in os.walk('../posts'):
   for name in files:       
	filename = os.path.join(root, name)
	print filename
	
	r = open(filename, 'r')
	o = r.read()
	r.close()
	posts[name] = o
	
write_inform_table_file(posts, 'posts')



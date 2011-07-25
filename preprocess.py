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
    if type(table) is types.DictType:
	for name, val in table.items():
	    f.write(to_inform_indexed_text(name) + " " + to_inform_indexed_text(val) + "\n")
	    if name.startswith("my"):
		print to_inform_indexed_text(val)

    if type(table) is types.ListType:
	for val in table:
	    f.write(to_inform_indexed_text(val) + "\n")
    f.close()

html_escape_table = {
    "&": "&amp;",
#    '"': "&quot;",
#    "'": "&apos;",
    ">": "&gt;",
    "<": "&lt;",
    "  ":"&nbsp;&nbsp;",
    "\t":"&nbsp;&nbsp;&nbsp;&nbsp;",
    "\n":"<br>"
    }

def html_escape(text):
    return "".join(html_escape_table.get(c,c) for c in text)

posts = dict()

for root, dirs, files in os.walk('..'):
    if root.startswith("../.git"): continue
    if root.startswith("../images"): continue
    if root.startswith("../run"): continue
    if root.startswith("../melon.inform/Index"): continue
    if root.startswith("../melon.inform/Build"): continue
    for name in files:       
	filename = os.path.join(root, name)
	print filename
	
	r = open(filename, 'r')
	o = r.read()
	r.close()
	posts[name] = html_escape(o)

	
write_inform_table_file(posts, 'posts')


print "images..."
images = []


for root, dirs, files in os.walk('../images'):
   for name in files:       
	filename = os.path.join(root, name)
	#print filename
	images.append(filename)

write_inform_table_file(images, 'images')



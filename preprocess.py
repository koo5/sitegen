#!/usr/bin/env python

import os
import time
import sys
import traceback # 4 nice errors
import types

def i7table_header(f, leng, name):
    f.write("* //72B4F7AB-F525-45F0-B5C7-FF9C0D38BCD7// "+name+"\n")
    f.write("! table of "+name+" (")
    f.write(str(leng))
    f.write(")\n")

def i7it(t):
    r = "S"
    for c in t:
	r += str(ord(c)) + ","
    r += "0;"
    return r

def i7table(name, length):
    f = open(name, 'w')
    i7table_header(f, length, name)
    return f

html_escape_table = {
    "&": "&amp;",
#    '"': "&quot;",
#    "'": "&apos;",
    ">": "&gt;",
    "<": "&lt;",
    "  ":"&nbsp;&nbsp;",
    "\t":"&nbsp;&nbsp;&nbsp;&nbsp;",
    "\n":"<br>",
    "\0":"NULL"
    }

def html_escape(text):
    return "".join(html_escape_table.get(c,c) for c in text)




posts = []

for root, dirs, files in os.walk('..'):
    if root.startswith("../.git"): continue
    if root.startswith("../images"): continue
    if root.startswith("../run"): continue
    if root.startswith("../melon.inform/Index"): continue
    if root.startswith("../melon.inform/Build"): continue
    for name in files:       
	filename = os.path.join(root, name)
	print filename
	stats = os.stat(filename)
	timestamp = stats[8]
	
	r = open(filename, 'r')
	o = r.read()
	r.close()
	if name == "todo":
	    print 'TODO-------'
	    print o
	    print '<<<<<<<<<<<'

	posts.append((name, timestamp, html_escape(o)))

posts = sorted(posts, key=lambda post: post[1])

f = i7table('posts', len(posts))
for tup in posts:
    f.write(i7it(tup[0]) + " " + i7it(tup[2]) + "\n")
f.close()



print "images..."
images = []

for root, dirs, files in os.walk('../images'):
   for name in files:       
	filename = os.path.join(root, name)
	#print filename
	images.append(filename)

f = i7table('images', len(images))
for i in images:
    f.write(i7it(i) + "\n")
f.close()


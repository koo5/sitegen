"Melon" by kook.

The site is a room.

[Section no world (in place of Section SR1/0 - Language in Standard Rules by Graham Nelson)]
[get rid of world model?]

Use MAX_STATIC_DATA of 38000000.
Use maximum indexed text length of at least 10241.
[big big tables]

File of posts (owned by another project) is called "posts".
File of files (owned by another project) is called "files".
File of images (owned by another project) is called "images".
File of fast cat (owned by another project) is called "fastcat".
[concatenating strings is damn slow, so we append to file]

table of posts
subject (indexed text)	content (indexed text)
with 1000 blank rows

table of files
name (indexed text)	content (indexed text)
with 1000 blank rows

table of images
name (indexed text)
with 1000 blank rows

current file name is some indexed text variable;

To start writing (file name - indexed text):
	now current file name is file name;
	write "" to file of fast cat;
	if file name  matches the regular expression ".+\.html$": [ends with]
		add file name to pages;

To append (x - indexed text):
	append "[x][line break]" to file of fast cat;

To close current file:
	choose blank row in table of files;
	now the name entry is current file name;
	let content be some indexed text;
	now content is "[text of file of fast cat]";
	now the content entry is content;


To write sitemap:
	start writing "sitemap.xml";
	append "[sitemap]";
	close current file;

To say sitemap:
	line "<?xml version='1.0' encoding='UTF-8'?>";
	line "<urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>";
	[http://www.google.com/support/webmasters/bin/answer.py?answer=34657&query=sitemap&type=]
	repeat with page running through pages:
		say "<url><loc>[encoded link page]</loc></url>";
	line "</urlset>";


To say footer:
	if search box is on_bottom:
		say "[search box]";
	say "</body></html>";

To say header:
	line "<div id='header'><h1>";
	say link site name to "/";
	line "</h1></div>";
	if search box is on_top, say "[search box]";

To say page start with title (title - indexed text):
	line "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/><title>";
	line title;
	line "</title>[css]</head><body>[header][sidebars]";
	

To write index:
	start writing "index.html";
	choose row 1 in table of posts;
	append "[page start with title subject entry]";
	repeat through table of posts:
		append "<div><h2>";
		append subject entry;
		append "</h2>";
		write random image with alt being the subject entry;
		append content entry;
		append "</div>";
	append "[footer]";
	close current file;

To write search:
	start writing "search.php";
	append "[page start with title site name]";
	append "<?php include 'searchbackend.php'?>";
	append "[footer]";
	close current file;

to write random image with alt being the (t - indexed text):
	if enable images is true:
		choose random row in table of images;
		append "<img src='[name entry]'[if titles for img alts is true] alt='[t]'[end if] class='[one of]left[or]right[at random]'>";
	

to write posts:
	repeat through table of posts:
		start writing "[subject entry].html";
		append "[page start with title subject entry]";
		append "<h2>[subject entry]</h2>";
		write random image with alt being the subject entry;
		append content entry;
		append "[footer]";
		close current file;
	
to say css:
	say "<link rel='stylesheet' href='main.css' type='text/css'>"
	

to line (t - indexed text):
	say "[t][line break]";

To decide which indexed text is encoded link (link - indexed text):
[	let result be some indexed text;]
	replace the text "&" in link with "&amp;";
	replace the text " " in link with "%20";
	replace the text "'" in link with "&quot;";
	decide on link;

to say link (caption - indexed text) to (link - indexed text):
	let enc be encoded link link;
	say "<a href='[enc]'>[caption]</a>";

to say sidebars:
	line "<div id='left-sidebar'>";
	repeat through table of posts:
		say link "[subject entry]" to "[subject entry].html";
		line "<br>";
	line "</div>";
	line "<div id='right-sidebar'>";
	line "<h1>Moo!</h1>";
	line "</div>";
	

To generate site:
	read file of posts into table of posts;
	read file of images into table of images;
	say "writing index.html[line break]";
	write index;
	say "writing posts[line break]";
	write posts;
	write search;
	write sitemap;
	write file of files from table of files;
	say "done[line break]";


site name is indexed text that varies;
pages is a list of indexed text that varies;

div is a kind of thing. div can be on_bottom, on_top, or hidden;

search box is a div; search box is on_bottom;

To say search box:
	say "<div align='right'><form action='search.php'><input type='text' name='searchstring'><input type='submit'></form></div>";

titles for img alts is a truth state that varies; titles for img alts is true;
enable images is a truth state that varies; enable images is true;














when play begins:
	now site name is "Webik";
	[on_top, on_bottom, nowhere]
	now search box is on_top;
	now titles for img alts is true;
	generate site.


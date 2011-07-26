"Melon" by kook.
The generator room is a room.




Section limits


Use MAX_STATIC_DATA of 380000000.
Use maximum indexed text length of at least 102410.


[increased some memory limits]




Section files


[input]
File of posts (owned by another project) is called "posts".
File of images (owned by another project) is called "images". [file names so we can add random ilustrations:)]
[output]
File of file infos (owned by another project) is called "fileinfos".
File of file contents (owned by another project) is called "filecontents".




Section tables


table of posts
subject (indexed text)	content (indexed text)
with 1000 blank rows


table of file infos
name (indexed text)	amount of bytes (number)
with 1000 blank rows

table of images
name (indexed text)
with 1000 blank rows




Section file output


length of currently writed file is a number variable;

To start writing (file name - indexed text):
	now the length of currently writed file is 0;
	choose blank row in table of file infos;
	now name entry is file name;
	now amount of bytes entry is 0;
	if file name  matches the regular expression ".+\.html$": [ends with it]
		add file name to pages;

To append (l - indexed text):
	say "appending...[line break]";
	append line "[l][line break]";

To append line (x - indexed text):
	say "appending[line break]";
	increase length of currently writed file by number of characters in x;
	say "counted[line break]";
	append "[x]" to file of file contents;
	say "appended [line break]";

To close current file:
	[choose last row in table of file infos;]
	let last be the number of filled rows in table of file infos;
	choose row last in table of file infos;
	now the amount of bytes entry is length of currently writed file;




Section sitemap


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




Section pages


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
		append "<div class='post'><h2>";
		append subject entry;
		append "</h2>";
		write random image with alt being the subject entry;
		append content entry;
		append "</div>";
		append "<div style='clear: both;'></div>";
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
		say "[subject entry][line break]";
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
	replace the text "&" in link with "&amp;";
	replace the text " " in link with "%20";
	replace the text "'" in link with "&quot;";
	decide on link;

to say link (caption - indexed text) to (link - indexed text):
	let enc be encoded link link;
	say "<a href='[enc]'>[caption]</a>";

To say post links:
	repeat through table of posts:
		say link "[subject entry]" to "[subject entry].html";
		line "<br>";

to say sidebars:
	line "<div id='left-sidebar'>";
	if links are on the left:
		say post links;
	line "</div>";
	line "<div id='right-sidebar'>";
	if links are on the right:
		say post links;
	line "<h1>Moo!</h1>";
	line "</div>";
	







Section generator


To write files:
	say "writing index.html[line break]";
	write index;
	say "writing posts[line break]";
	write posts;
	write search;
	write sitemap;

To generate files:
	write "" to file of file contents;
	read file of posts into table of posts;
	read file of images into table of images;
	write files;
	write file of file infos from table of file infos;
	say "done[line break]";

site name is indexed text that varies;
pages is a list of indexed text that varies;
titles for img alts is a truth state that varies; titles for img alts is true;
enable images is a truth state that varies; enable images is true;
div is a kind of thing. div can be on_bottom, on_top, on the left, on the right, or hidden;



Section search box


search box is a div; search box is on_bottom;

To say search box:
	say "<div align='right'><form action='search.php'><input type='text' name='searchstring'><input type='submit'></form></div>";

Section links


links are a div; links are on the left;







Section some site


To generate site:
	now site name is "Webik";
	[on_top, on_bottom, nowhere]
	now search box is on_top;
	now titles for img alts is true;
	generate files.




when play begins:
	generate site;
[	now site name is "[text of file of posts]";]

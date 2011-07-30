"sitegen" by kook.
The generator room is a room.









Section settings

div is a kind of thing. 
footer is a container.
header is a container.
left sidebar is a container.
right sidebar is a container.
links are a div; links are in the left sidebar;
site name is indexed text that varies;
titles for img alts is a truth state that varies;
titles for img alts is true;
enable images is a truth state that varies;
enable images is true;
number of words in excerpts is a number that varies; 
number of words in excerpts is 60;
number of excerpts is a number that varies;
number of excerpts is 10;








[
each game needs a room
"indexed text" is changable text, as opposed to "text", which is immutable
you cant write To serve "url":
It seems that sometimes you cant write utf8 in a table to a file, but you can write it as text, and print it on screen
when you choose a row in a table, it's local to the rule
strings, even simple appending to them, are unbelievably slow
stuff is indexed from 1

]





Section memory limits

Use MAX_STATIC_DATA of 380000000.
Use maximum indexed text length of at least 102410.






Section tables

[input]
table of posts
subject (indexed text)	content (indexed text)
with 1000 blank rows

table of images
name (indexed text)
with 1000 blank rows

[output]
table of file infos
name (indexed text)	amount of bytes (number)
with 1000 blank rows







Section files

[input]
File of posts (owned by another project) is called "posts".
File of images (owned by another project) is called "images". [table of image file names so we can add random ilustrations:)]
[output]
File of file infos (owned by another project) is called "fileinfos".
File of file contents (owned by another project) is called "filecontents".







Section file output

[we are appending everything to the file of file contents and writing the file names and lengths table to the file of file infos, to be cut later in python:)]

length of currently writed file is a number variable;
pages is a list of indexed text that varies;

To start writing (file name - indexed text):
	now the length of currently writed file is 0;
	choose blank row in table of file infos;
	now name entry is file name;
	now amount of bytes entry is 0;
	if file name  matches the regular expression ".+\.html$": [ends with it]
		add file name to pages;

To append (l - indexed text):
	increase length of currently writed file by number of characters in l;
	append "[l]" to file of file contents;

To write (l - indexed text):
	append "[l][line break]";

To close current file:
	let last row be the number of filled rows in table of file infos;
	choose row last row in table of file infos;
	now the amount of bytes entry is the length of currently writed file;







Section utilities

To decide which number is the smaller of (a - number) and (b - number):
	if a is less than b:
		decide on a;
	else:
		decide on b;

to line (t - indexed text):
	say "[t][line break]";

To decide which indexed text is urlencoded url of (link - indexed text):
	replace the text "&" in link with "&amp;";
	replace the text " " in link with "%20";
	replace the text "'" in link with "&quot;";
	decide on link;







Section sitemap

To write sitemap:
	start writing "sitemap.xml";
	write "[sitemap]";
	close current file;

To say sitemap:
	line "<?xml version='1.0' encoding='UTF-8'?>";
	line "<urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>";
	[http://www.google.com/support/webmasters/bin/answer.py?answer=34657&query=sitemap&type=]
	repeat with page running through pages:
		say "<url><loc>[urlencoded url of page]</loc></url>";
	line "</urlset>";







Section pages

To say page footer:
	if search box is in footer:
		say "[search box]";
		
To say page end:
	say "[page footer]</body></html>";

To say page header:
	line "<div id='header'><h1>";
	link site name to "/";
	line "</h1></div>";
	if search box is in header:
		 say "[search box]";

To say page start with title of (title - indexed text):
	line "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/><title>";
	line title;
	line "</title>[css]</head><body>[page header][sidebars]";

to say sidebars:
	line "<div id='left-sidebar'>";
	if links are in left sidebar:
		say post links;
	line "</div>";
	line "<div id='right-sidebar'>";
	if links are in right sidebar:
		say post links;
	line "<h1>Moo!</h1>";
	line "</div>";

To decide which indexed text is excerpt of (content - indexed text):
	let excerpt be some indexed text;
	let words count be the smaller of the number of words in content and number of words in excerpts;
	say "excerpting...";
	repeat with word index running from 1 to words count:
		now excerpt is "[excerpt] [word number word index in content]";
	say "excerpt is [excerpt][paragraph break]";
	decide on excerpt;


To write index:
	say "writing index.html[line break]";
	start writing "index.html";
	choose row 1 in table of posts;
	write "[page start with title of subject entry]";
	let excerpts count be the smaller of the number of excerpts and the number of filled rows in the table of posts;
	repeat with row index running from 1 to excerpts count:
		choose row row index in table of posts;
		write "<div class='post'><h2>";
		write "[post link to subject entry]";
		write "</h2>";
		write random image with alt being the subject entry;
		write excerpt of content entry;
		write " <a href='[subject entry].html'>...</a>";
		write "</div>";
		write "<div style='clear: both;'></div>";
	write "[page end]";
	close current file;


to write random image with alt being the (t - indexed text):
	if enable images is true:
		choose random row in table of images;
		write "<img src='[name entry]'[if titles for img alts is true] alt='[t]'[end if] class='[one of]left[or]right[at random]'>";
	

to write posts:
	repeat through table of posts:
		say "writing [subject entry][line break]";
		start writing "[subject entry].html";
		write "[page start with title of subject entry]";
		write "<h2>[subject entry]</h2>";
		write random image with alt being the subject entry;
		write content entry;
		write "[page end]";
		close current file;

to say css:
	say "<link rel='stylesheet' href='main.css' type='text/css'>"
	

to say link (caption - indexed text) to (link - indexed text):
	link caption to link

to link (caption - indexed text) to (link - indexed text):
	let enc be urlencoded url of link;
	say "<a href='[enc]'>[caption]</a>";

To say post link to (subject entry - indexed text):
	say link "[subject entry]" to "[subject entry].html";

To say post links:
	repeat through table of posts:
		say post link to subject entry;
		line "<br>";






Section search

search box is a div;[ search box is in footer;]

To say search box:
	say "<div align='right'><form action='search.php'><input type='text' name='searchstring'><input type='submit'></form></div>";

To write search:
	start writing "search.php";
	write "[page start with title of site name]";
	write "<?php include 'searchbackend.php'?>";
	write "[page end]";
	close current file;







Section generator

To write files:
	write index;
	write posts;
	write search;
	write sitemap;

To generate site:
	write "" to file of file contents;
	say "Loading...[line break]";
	read file of posts into table of posts;
	read file of images into table of images;
	write files;
	write file of file infos from table of file infos;
	say "done [site name] [line break]";








Section some site

To generate some site:
	now site name is "Webik";
	now search box is in header;
	now titles for img alts is true;
	now number of excerpts is 10;
	now number of words in excerpts is 100;
	generate site.


when play begins:
	generate site;

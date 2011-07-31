"sitegen" by kook.








when play begins:
	generate webik;






Section webik

To generate webik:
	now site name is "Webik";
	move search box to header;
	move links to right sidebar;
	now number of excerpts is 10;
	now number of words in excerpts is 10;
	generate site.







Section generator

To generate site:
	write "" to file of file contents;
	blank out the whole of the table of file infos;
	say "Loading...[line break]";
	read file of posts into table of posts;
	read file of images into table of images;
	write files;
	write file of file infos from table of file infos;
	say "done [site name] [line break]";

To write files:
	write index;
	write posts;
	write search;
	write sitemap;









Section pages

To write index:
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

to write posts:
	repeat through table of posts:
		start writing "[subject entry].html";
		write "[page start with title of subject entry]";
		write "<h2>[subject entry]</h2>";
		write random image with alt being the subject entry;
		write content entry;
		write "[page end]";
		close current file;







Section misc files

To write sitemap:
	start writing "sitemap.xml";
	write "<?xml version='1.0' encoding='UTF-8'?>";
	write "<urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>";
	repeat with page running through pages:
		write "<url><loc>[urlencoded url of page]</loc></url>";
	write "</urlset>";
	close current file;

To write search:
	start writing "search.php";
	write "[page start with title of site name]";
	write "<?php include 'searchbackend.php'?>";
	write "[page end]";
	close current file;







Section page parts

To say page start with title of (title - indexed text):
	line "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/><title>";
	line title;
	line "</title>[css]</head><body>[page header][sidebars]";

To say page end:
	say "[page footer]</body></html>";

To say page header:
	line "<div id='header'><h1>";
	link site name to "/";
	line "</h1></div>";
	if search box is in header:
		 say "[search box]";

To say page footer:
	if search box is in footer:
		say "[search box]";

to say sidebars:
	line "<div id='left-sidebar'>";
	if links are in left sidebar:
		say post links;
	line "</div>";
	line "<div id='right-sidebar'>";
	line "<h1>Moo!</h1>";
	if links are in the right sidebar:
		say post links;
	line "</div>";










Section stuff in pages

To decide which indexed text is excerpt of (content - indexed text):
	let excerpt be some indexed text;
	let words count be the smaller of the number of words in content and number of words in excerpts;
	repeat with word index running from 1 to words count:
		now excerpt is "[excerpt] [word number word index in content]";
	decide on excerpt;

to write random image with alt being the (t - indexed text):
	if enable images is on:
		choose random row in table of images;
		write "<img src='[name entry]'[if post titles in img alt tags is on] alt='[t]'[end if] class='[one of]left[or]right[at random]'>";

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

To say search box:
	say "<div align='right'><form action='search.php'><input type='text' name='searchstring'><input type='submit'></form></div>";









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

understand "gen" as generating; generating is an action applying to nothing;
carry out generating:
	generate site;








Section variables

The generator room is a room.
site name is indexed text that varies;

footer, header, left sidebar and right sidebar are containers in the generator room;
links are in the left sidebar;
search box is here;

switch is a kind of thing; switch can be on or off;
post titles in img alt tags is an on switch;
enable images is a an on switch;

number of words in excerpts is a number that varies; 
number of words in excerpts is 60;
number of excerpts is a number that varies;
number of excerpts is 10;









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
	say "writing [file name][line break]";
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







Section gotchas

[
"indexed text" is changable text, as opposed to "text", which is immutable
you cant write To serve "url":
It seems that sometimes you cant write utf8 in a table to a file, but you can write it as text, or print it on screen
when you choose a row in a table, it's local to the function
strings, even simple appending to them, are unbelievably slow
stuff is indexed from 1
"number of filled rows in" goes thru all the rows - slow
]

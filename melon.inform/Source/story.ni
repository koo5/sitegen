"sitegen" by kook.
The generator room is a room.
[each game needs a room:)]




[indexed text is changable text, as opposed to text, which is immutable



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

To start writing (file name - indexed text):
	now the length of currently writed file is 0;
	choose blank row in table of file infos;
	now name entry is file name;
	now amount of bytes entry is 0;
	if file name  matches the regular expression ".+\.html$": [ends with it]
		add file name to pages;

To append (l - indexed text):
	increase length of currently writed file by number of characters in x;
	append "[x]" to file of file contents;

To write (l - indexed text):
	append "[l][line break]";

To close current file:
	choose row last_row in table of file infos;
	now the amount of bytes entry is the length of currently writed file;







Section utilities
To decide which number is the smaller of (a - number) and (b - number):
	if a is less than b:
		decide on a;
	else:
		decide on b;

To decide which number is the last_row of (t - table name):
	decide on the number of filled rows in table of file infos;
	[stuff is indexed from 1 in inform7]







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
		say "<url><loc>[urlencoded url of page]</loc></url>";
	line "</urlset>";







Section pages
To say page footer:
	if search box is on_bottom:
		say "[search box]";
		
To say page end:
	say "[page footer]</body></html>";

To say page header:
	line "<div id='header'><h1>";
	link site name to "/";
	line "</h1></div>";
	if search box is on_top, say "[search box]";

To say page start with title (title - indexed text):
	line "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/><title>";
	line title;
	line "</title>[css]</head><body>[header][sidebars]";
	
To decide which indexed text is excerpt of (content - indexed text):
	let excerpt be some indexed text;
	let words count be the smaller of the number of words in content and number of words in excerpts;
	say "excerpting...";
	repeat with word index running from 1 to words count:
		now excerpt is "[excerpt] [word number word index in content]";
	say "excerpt is [excerpt][paragraph break]";
	decide on excerpt;

To write index:
	start writing "index.html";
	choose row 1 in table of posts;
	append "[page start with title subject entry]";
	let excerpts count be the smaller of the number of excerpts and the number of filled rows in the table of posts;
	repeat with row index running from 1 to excerpts count:
		choose row row index in table of posts;
		append "<div class='post'><h2>";
		append "[post link to subject entry]";
		append "</h2>";
		write random image with alt being the subject entry;
		append excerpt of content entry;
		append " <a href='[subject entry].html'>...</a>";
		append "</div>";
		append "<div style='clear: both;'></div>";
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

To decide which indexed text is urlencoded url of (link - indexed text):
	replace the text "&" in link with "&amp;";
	replace the text " " in link with "%20";
	replace the text "'" in link with "&quot;";
	decide on link;

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


pages is a list of indexed text that varies;

site name is indexed text that varies;
titles for img alts is a truth state that varies; titles for img alts is true;
enable images is a truth state that varies; enable images is true;
div is a kind of thing. div can be on_bottom, on_top, on the left, on the right, or hidden;
number of words in excerpts is a number that varies;
number of excerpts is a number that varies;


Section search
search box is a div; search box is on_bottom;

To say search box:
	say "<div align='right'><form action='search.php'><input type='text' name='searchstring'><input type='submit'></form></div>";

To write search:
	start writing "search.php";
	append "[page start with title site name]";
	append "<?php include 'searchbackend.php'?>";
	append "[footer]";
	close current file;


Section links


links are a div; links are on the left;







Section some site


To generate site:
	now site name is "Webik";
	[on_top, on_bottom, nowhere]
	now search box is on_top;
	now titles for img alts is true;
	now number of excerpts is 10;
	now number of words in excerpts is 100;
	generate files.




when play begins:
	generate site;
[	now site name is "[text of file of posts]";]

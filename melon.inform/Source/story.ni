"Melon" by kook.

The site is a room.

Use MAX_STATIC_DATA of 380000000.
Use maximum indexed text length of at least 10241024.

[big big tables]

File of posts (owned by another project) is called "posts".
File of files (owned by another project) is called "files".
File of fast cat (owned by another project) is called "fastcat".
[concatenating strings is damn slow, so we append to file]

table of posts
subject (indexed text)	content (indexed text)
with 1000 blank rows

table of files
name (indexed text)	content (indexed text)
with 1000 blank rows

current file name is some indexed text variable;

To start writing (file name - indexed text):
	now current file name is file name;
	write "" to file of fast cat;
	if file name  matches the regular expression ".+\.html$": [ends with]
		add file name to pages;

To append (x - indexed text):
	append "[x][line break]" to file of fast cat;

To append text (x - text):
	append "[x][line break]" to file of fast cat;

To close current file:
	choose blank row in table of files;
	now the name entry is current file name;
	let content be some indexed text;
	now content is "[text of file of fast cat]";
	now the content entry is content;

To generate site:
	read file of posts into table of posts;
	say "writing index.html[line break]";
	write index;
	say "writing posts[line break]";
	write posts;
	write sitemap;
	write file of files from table of files;
	say "done[line break]";

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

To say header:
	line "<div id='header'><h1>";
	say link site name to "/";
	line "</div></h1>";

To say page start with title (title - indexed text):
	line "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/><title>";
	line title;
	line "</title>[css]</head><body>[header][sidebars]";
	

To write index:
	start writing "index.html";
	choose row 1 in table of posts;
	append "[page start with title subject entry]";
	repeat through table of posts:
		append text "<h2>";
		append subject entry;
		append text "</h2>";
		append content entry;
	append text "</body></html>";
	close current file;

to write posts:
	repeat through table of posts:
		start writing "[subject entry].html";
		append "<html><head>[css]<title>";
		append subject entry;
		append "</title></head><body>[header][sidebars]";
		append text "<h2>";
		append subject entry;
		append text "</h2>";
		append content entry;
		append text "</body></html>";
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
	
	
site name is indexed text that varies;

pages is a list of indexed text that varies;



















when play begins:
	now site name is "Webik";
	generate site.


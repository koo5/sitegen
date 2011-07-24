"Melon" by kook.

The site is a room.

Use MAX_STATIC_DATA of 38000000.
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

When play begins:
	read file of posts into table of posts;
	say "writing index.html[line break]";
	write index;
	say "writing posts[line break]";
	write posts;
	write file of files from table of files;
	say "done[line break]";

To write index:
	start writing "index.html";
	append "<html><head><title>";
	choose row 1 in table of posts;
	append subject entry;
	append text "</title>[css]</head><body>[sidebars]";
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
		append "</title></head><body>[sidebars]";
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

to say href (caption - indexed text) to (link - indexed text):
	let enc be encoded link link;
	say "<a href='[enc]'>[caption]</a>";

to say sidebars:
	say href "a" to " bbb";
	line "<div id='left-sidebar'>";
	repeat through table of posts:
		line "<a href=[subject entry].html>[subject entry]</a><br>";
	line "</div>";
	line "<div id='right-sidebar'>";
	line "<h1>Moo!</h1>";
	line "</div>";
	
find
=====
* $ find . -iname '*.jpg'

find and exec a command
=====
* Rename all .jpg to .jpg.backup
* $ find . -iname '*.jpg' -exec sh -c 'mv "$0" "$0".backup' {} \;

find and exec multiple commands
=====
* Add multiple -exec for each command
* Copy all .jpg to .jpg.backup
* Remove all .jpg
* $ find . -iname '*.jpg' -exec sh -c 'mv "$0" "$0".backup && rm "$0"' {} \;
* OR
* $ find . -iname '*.jpg' -exec sh -c 'cp "$0" "$0".backup' {} \; -exec sh -c 'rm "$0"' {} \;

find all UTF-8 files
=====
* $ find . -type f -exec sh -c 'file --mime "$0"' {} \; | grep utf
* find all non-utf8 files
* $ find . -type f -exec sh -c 'file --mime "$0"' {} \; | grep -v utf

find without leading path such as ./ and exec a command (which means getting basename only)
=====
* Remove all jpg files
* Set % as variable/file name
* $ find . -iname '*.jpg' -printf '%P\n' | xargs -I % sh -c 'rm "$0"' %

find and convert file to UTF-8
=====
* Make sure to install libiconv
* $ find . -type f -iname '*.txt' -exec sh -c 'iconv -f $(file -bi "$0" | sed -e "s/.*[ ]charset=//") -t utf-8 "$0" > "$0.converted" && mv "$0.converted" "$0"' {} \;

find with multiple conditions
=====
* -o means OR, -a means AND, -not means NOT
* find all jpg or png or gif
* $ find . -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif'

find with file size
=====
* Auto detect which unit to use
* $ du -sh *
* OR
* $ find . -iname '*.jpg' -exec sh -c 'ls -lh "$0"' {} \;
* KB
* $ find . -iname '*.jpg' -exec sh -c 'ls -s --block-size=K "$0"' {} \;
* MB
* $ find . -iname '*.jpg' -exec sh -c 'ls -s --block-size=M "$0"' {} \;
* GB
* $ find . -iname '*.jpg' -exec sh -c 'ls -s --block-size=G "$0"' {} \;

Replace / Remove a string in a file
=====
* Replace all "\n\r" with ","
* $ tr "\n\r" "," < input.txt  > output.txt
* Remove all "\n\r"
* $ tr -d "\n\r" < input.txt  > output.txt

find
=====
* $ find . -iname '*.jpg'

find and exec a command
=====
* Rename all .jpg to .jpg.backup
* $ find . -iname '*.jpg' -exec bash -c 'mv $0 $0.backup' {} \;

find and exec multiple commands
=====
* Add multiple -exec for each command
* Copy all .jpg to .jpg.backup
* Remove all .jpg
* $ find . -iname '*.jpg' -exec bash -c 'mv $0 $0.backup && rm $0' {} \;
* OR
* $ find . -iname '*.jpg' -exec bash -c 'cp $0 $0.backup' {} \; -exec bash -c 'rm $0' {} \;

find all utf8 files
=====
* $ find . -type f -exec bash -c 'file --mime $0' {} \; | grep utf
* find all non-utf8 files
* $ find . -type f -exec bash -c 'file --mime $0' {} \; | grep -v utf

find without leading path such as ./
=====
* $ find . -iname '*.jpg' -printf '%P\n'

find without leading path such as ./ and exec a command
=====
* Remove all jpg files
* Set % as variable/file name
* $ find . -iname '*.jpg' -printf '%P\n' | xargs -I % bash -c 'rm $0' %
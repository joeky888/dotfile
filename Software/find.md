find
=====
* $ find . -iname '*.jpg'

find and exec a command
=====
* Rename all .jpg to .jpg.backup
* $ find .. -iname '*.jpg' -exec bash -c 'mv $0 $0.backup' {} \;

find and exec multiple commands
=====
* Add multiple -exec for each command
* Copy all .jpg to .jpg.backup
* Remove all .jpg
* $ find .. -iname '*.jpg' -exec bash -c 'mv $0 $0.backup && rm $0' {} \;
* OR
* $ find .. -iname '*.jpg' -exec bash -c 'cp $0 $0.backup' {} \; -exec bash -c 'rm $0' {} \;
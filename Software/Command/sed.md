Remove all lines which contain a string
=====
* $ sed -i '/string/d' filename
* Ignore case
* $ sed -i '/string/Id' filename

Remove all lines which not contain a string
=====
* $ sed -i '/string/!d' filename
* Ignore case
* $ sed -i '/string/Id' filename

Remove all empty lines
=====
* $ sed -i '/^\s*$/d' filename

Replace all empty lines with one empty lines
=====
* $ sed -i '/^$/N;/^\n$/D' filename

Remove all trailing whitespace
=====
* $ sed -i 's/\s*$//g' filename

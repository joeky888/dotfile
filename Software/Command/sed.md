Get only the matched string
=====
* $ echo aaaTESTbbb | grep -o "TEST"

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
```sh
sed -i '/^\s*$/d' filename
```

Replace all empty lines with one empty lines
=====
```sh
sed -i '/^$/N;/^\n$/D' filename
```

Remove all trailing whitespace
=====
```sh
sed -i 's/\s*$//g' filename
```

Remove lines by using line numbers
=====
* Remove lines 5 through 10 and 12
```sh
sed -i '5,10d;12d' filename
```

Append lines to a pattern
=====
```sh
sed -i '/pattern/a \
Hi, \
How are you!' filename
```

Preppend lines to a pattern
=====
```sh
sed -i '/pattern/i \
Hi, \
How are you!' filename
```

Preppend lines to a line number
=====
* Insert "Hi, this is Line 8" to the 8th line
```sh
sed -i '8iHi, \
this is Line 8' filename
```

Args
=====
```conf
-C              UTF8
-Mutf8          UTF8
-i              Replace in place (current file)
-e              Regex
```

Replace all strings in a file
=====
```sh
perl -C -Mutf8 -pi -e 's/blue/red/g' ~/path/file
```

Remove all lines contains a string
=====
```sh
# case
perl -C -Mutf8 -ni -e 'print if !/mystring/' ~/path/file
# ignore case
perl -C -Mutf8 -ni -e 'print if !/mystring/i' ~/path/file
```

Extract regex from multiple lines
=====
```txt
start here
and
multiple lines
end here
and the rest
```
* $ `perl -0777 -ne 'print $1 if /(start.*?end)/s;' file.txt`

Replace logs with terminal colors to html
=====
```sh
! [ $1 ] && echo "Usage: ./toHtml.sh <filename>" && exit 1

cat $1 | perl -C -Mutf8 -p -e 's/ /&emsp;/g' | \
perl -C -Mutf8 -p -e 's/\n/<\/br>/g'         | \
perl -C -Mutf8 -p -e 's/\[39m/\<\/font>/g' | \
perl -C -Mutf8 -p -e 's/\[30m/<font color="black">/g' | \
perl -C -Mutf8 -p -e 's/\[31m/<font color="#E90000">/g' | \
perl -C -Mutf8 -p -e 's/\[32m/<font color="#00AF00">/g' | \
perl -C -Mutf8 -p -e 's/\[33m/<font color="#F4BF75">/g' | \
perl -C -Mutf8 -p -e 's/\[34m/<font color="#00AFFF">/g' | \
perl -C -Mutf8 -p -e 's/\[35m/<font color="#AE81FF">/g' | \
perl -C -Mutf8 -p -e 's/\[36m/<font color="#A1EFE4">/g' | \
perl -C -Mutf8 -p -e 's/\[37m/<font color="#F8F8F2">/g' | \
perl -C -Mutf8 -p -e 's/\[90m/<font color="#7E8E91">/g' | \
perl -C -Mutf8 -p -e 's/\[91m/<font color="#F92672">/g' | \
perl -C -Mutf8 -p -e 's/\[92m/<font color="#A6E22E">/g' | \
perl -C -Mutf8 -p -e 's/\[93m/<font color="#FFFF00">/g' | \
perl -C -Mutf8 -p -e 's/\[94m/<font color="#66D9EF">/g' | \
perl -C -Mutf8 -p -e 's/\[95m/<font color="#AE81FF">/g' | \
perl -C -Mutf8 -p -e 's/\[96m/<font color="#A1EFE4">/g' | \
perl -C -Mutf8 -p -e 's/\[97m/<font color="#F8F8F2">/g' | \
perl -C -Mutf8 -p -e 's/$/<style>body { background-color: black; color:white; font-family: "Ubuntu Mono","Consolas","Lucida Console", monospace; }<\/style>/g'
```

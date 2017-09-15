Disable bold and italic font
=====
* :echo $VIMRUNTIME
* $ cd %VIMRUNTIME%
* In /syntax
* $ sudo sed -i 's/=bold/=NONE/g' \*.vim
* $ sudo sed -i 's/=italic/=NONE/g' \*.vim

sudo
=====
* Use sudoedit instead of sudo vim
* $ sudoedit filename

Remove lines contains a string
====
* :g/string/d

Remove lines contains a pattern
====
* :g/pattern/d

Generate a list of numbers
=====
* :put =range(11,15)
* The five lines are:
```vim
11
12
13
14
15
```

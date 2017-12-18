System Clipboard not working
=====
* Check environment
```vim
echo has('clipboard')
echo has('unnamedplus')
echo v:register
```
* If everything seems fine, here is a quick fix
```vim
set clipboard=
nnoremap <C-c> mjV"+y:redraw!<CR>`ji
inoremap <C-c> <C-\><C-o>mj<C-o>V"+y<C-o>:redraw!<CR><C-o>`j
vnoremap <C-c> "+y:redraw!<CR>gv
cnoremap <C-c> <C-y>
```

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

Regex
=====
```conf
^   Begin of line
$   End of line

\s  whitespace character        \S  non-whitespace character
\d  number digit                \D  non-number digit
\x  hex digit	                \X  non-hex digit
\o  octal digit	                \O  non-octal digit
\a  alphabetic character        \A  non-alphabetic character
\w  ASCII letters and numbers   \W  non-letters or non-numbers
\l  lowercase character         \L  non-lowercase character
\u  uppercase character         \U  non-uppercase character

\e  <Esc>
\t  <Tab>
\r  <CR>
\b  <BS> <Backspace>
\n  line break

.   any character
*   matches 0 or more
\+  matches 1 or more
\=  matches 0 or 1
\{n,m}      matches from n to m times
\{n}        matches exactly n times
\{,m}       matches at most m times
\{n,}       matches at least n times

[A-Za-z0-9_]    alphanumeric
[^A-Za-z0-9_]   non-alphanumeric

[:alnum:]       ASCII letters and numbers
[:alpha:]       ASCII letters
[:blank:]       space and tab
[:digit:]       decimal digits '0' to '9'
[:lower:]       lowercase letters
[:upper:]       uppercase letters (all letters when
[:print:]       printable characters including space
[:space:]       whitespace characters: space, tab, CR, NL, vertical tab
[:xdigit:]      hexadecimal digits: 0-9, a-f, A-F
[:return:]      the <CR> character
[:tab:]         the <Tab> character
[\u0021-\u002F]     range of unicode
[^\u0000-\u007F]    range of non-ASCII (Full-width characters)
```

Build Mingw64 vim under cygwin
=====
* $ cd src
* Edit Make\_cyg.mak and Make\_cyg\_ming.mak
* $ choco install miniconda miniconda3 -y
* $ python2 --version ; python3 --version
```make
# Make_cyg.mak
CROSS_COMPILE = x86_64-w64-mingw32-
UNDER_CYGWIN = yes

# Make_cyg_ming.mak
ARCH=x86-64
FEATURES=HUGE
CROSS=yes
GUI=yes
STATIC_STDCPLUS=yes
PYTHON=/cygdrive/c/ProgramData/Miniconda2
PYTHON3=/cygdrive/c/ProgramData/Miniconda3
DYNAMIC_PYTHON=yes
DYNAMIC_PYTHON3=yes
PYTHON_VER=27
PYTHON3_VER=36
PYTHONINC=-I$(PYTHON)/include
PYTHON3INC=-I$(PYTHON3)/include
PYTHONLIB=-L$(PYTHON)/libs -lpython$(PYTHON_VER)
PYTHON3LIB=-L$(PYTHON3)/libs -lpython$(PYTHON3_VER)
```
* $ make -f Make\_cyg.mak
* $ cp gvim.exe ../runtime/gvim.exe
* Open gvim.exe under runtime folder

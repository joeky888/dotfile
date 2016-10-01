git diff ignore
=====
* ignore all line break, tabs, whitespaces ("\n \t \ "), using POSIX regex
* $ git diff --no-index --word-diff-regex=[^[:space:]] a.html b.html
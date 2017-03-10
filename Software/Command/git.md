git diff ignore
=====
* ignore all line break, tabs, whitespaces ("\n \t \ "), using POSIX regex
* $ git diff --no-index --word-diff-regex=[^[:space:]] a.html b.html

Add submodule
=====
```bash
git submodule add --depth 1 https://github.com/robbyrussell/oh-my-zsh.git
```
* Add "shallow = true" to .gitmodules

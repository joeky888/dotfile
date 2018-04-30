git diff ignore
=====
* ignore all line break, tabs, whitespaces ("\n \t \ "), using POSIX regex
* $ git diff --no-index --word-diff-regex=[^[:space:]] a.html b.html

Add submodule
=====
```sh
git submodule add --depth 1 https://github.com/robbyrussell/oh-my-zsh.git
```
* Add "shallow = true" to .gitmodules
* $ git submodule update --init --recursive

Clone all branches
=====
* $ git clone -b AnyBranchName URL
* $ git branch -a

Fetch/Pull a new branch
=====
* $ vim .git/config
```conf
# Change this line
fetch = +refs/heads/master:refs/remotes/origin/master
# To
fetch = +refs/heads/*:refs/remotes/origin/*
```
* $ git fetch origin NewBranch

Modify a commit message
=====
* $ git commit --amend

History commits of a file
=====
* $ git log -p filename

git restore a single file
=====
* $ git checkout HEAD -- my-file.txt

git restore a commit
=====
* Unpushed commit
* $ git reset --hard <commit>
* $ git clean -xdf
* Pushed commit
    * Revert Multiple commit (Preferred)
    * $ git revert --no-commit <commit>..master
    * Revert one commit
    * $ git revert --no-commit <commit>
    * $ git status # Conflicts check
    * $ git commit

Git push won't do anything (Everything up-to-date)
=====
* There must be another branch
* $ git branch
* Switch back to master
* $ git checkout master
* $ git push origin master

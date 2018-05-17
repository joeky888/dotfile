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
* Or
* $ git fetch --all

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

Gogs server push-to-deploy (Make a git hook just like a git mirror)
=====
* gitRepo means git server to push
* webSite means website to depoly from gitRepo
* Add git hooks gitRepo/.git/hooks
* $ chmod u+x gitRepo/.git/hooks
* $ vim gitRepo/.git/hooks
```sh
#!/bin/bash
while read oldrev newrev refname
do
    branch=$(git rev-parse --symbolic --abbrev-ref $refname)
    if [ "master" == "$branch" ]; then
        export GIT_WORK_TREE=/home/joeky/webSite
        export GIT_DIR=${GIT_WORK_TREE}/.git

        cd ${GIT_WORK_TREE}
        git pull origin master
        git reset --hard origin/master
    fi
done
```
* $ cd /home/joeky && git clone http://server/gitRepo webSite

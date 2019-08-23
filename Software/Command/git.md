git https push without password
=====
* $ cd git-project
* $ git config credential.helper store

git diff ignore
=====
* ignore all line break, tabs, whitespaces ("\n \t \ "), using POSIX regex
* $ git diff --no-index --word-diff-regex=[^[:space:]] a.html b.html

Add submodule
=====
```sh
cd ~/dotfile
git submodule add -b branchName -- https://github.com/robbyrussell/oh-my-zsh.git
```
* Add "shallow = true" to .gitmodules
* $ git submodule update --init

Clone all branches
=====
* $ git clone -b AnyBranchName URL
* $ git branch -a

Push all branches and tags
=====
* $ git push --mirror

Fetch/Pull a new branch
=====
* $ vim .git/config
```gitconfig
# Change this line
fetch = +refs/heads/master:refs/remotes/origin/master
# To
fetch = +refs/heads/*:refs/remotes/origin/*
```
* $ git fetch origin NewBranch
* Or
* $ git fetch --all

Upgrade a forked project
=====
* $ git remote add author https://github.com/robbyrussell/oh-my-zsh.git
* $ git remote add myfork https://github.com/joeky/oh-my-zsh.git
* $ git remote -v # Should see 2 remote url
* $ git pull author # Fetch and merge author's repo to local
* $ git push myfork

Modify a commit message
=====
* $ git commit --amend

History commits of a file
=====
* $ git log -p filename

git restore a single file
=====
* $ git checkout -- my-file.txt
* Or
* $ git checkout HEAD -- my-file.txt

git rebase error
=====
* First, fix Conflicts without commit it
* $ git add --all
<!-- * $ git commit -m "Merge conflicts" -->
* $ git rebase --continue

Export and import a patch
=====
* $ git diff > save.patch
* $ git reset --hard
* $ git apply save.patch

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

Merge commit from another branch
=====
* $ git cherry-pick d42c389f

Pack to git bundle (.bundle files)
=====
* $ git bundle create repo.bundle --all
* Unpack
* $ git bundle verify repo.bundle
* $ git clone repo.bundle

Collection of github badges
=====
* ![GitHub stars](https://img.shields.io/github/stars/joeky888/app-fast.svg?style=social&label=Stars)
* ![GitHub forks](https://img.shields.io/github/forks/joeky888/app-fast.svg?style=social&label=Fork)

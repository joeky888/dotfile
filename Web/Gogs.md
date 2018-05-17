Add an user named git
=====
* $ sudo adduser --disabled-login --gecos 'Gogs' git

Run Gogs
=====
* $ ./gogs web

Setup Gogs
=====
* Goto localhost:3000
* Set DB to SQLite
* Use Gogs built-in ssh-server
    * Set port to 2222 or whatever, don't use the same port that server uses to run ssh server
* Add ssh public key to user profile

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

        echo "Hi ${GOGS_AUTH_USER_NAME}, thank you so much for your efforts!"
        echo "Now I am going to mirror this project to ${GIT_WORK_TREE}."
        echo "Hold tight..."

        cd ${GIT_WORK_TREE}
        git pull origin master
        git reset --hard origin/master
    fi
done
```
* $ cd /home/joeky && git clone http://server/gitRepo webSite

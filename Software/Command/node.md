html
=====
* html
  * head
  * body
    * header
      * nav
    * main
      * article
        * section
    * footer


Install fnm node-lts
=====
```bash
brew install fnm
fnm install --lts
fnm use lts/latest
npm i -g npm@latest
fnm ls

fnm uninstall v20.10.0 # Remove LTS
```

Add fnm to current project
=====
```sh
# Adding a .node-version to your project is as simple as:

node --version
# v14.18.3
node --version > .node-version
```

package.json
=====
* ^：鎖住第一碼(即A) 不得變更。如^1.2.2，則安裝範圍是>=1.2.2 且 <2.0.0。即須符合`1.*.*`。
* ~：鎖住第二碼(即B) 不得變更。如~1.2.2，則安裝範圍是>=1.2.2且<1.3.0。即須符合`1.2.*`。


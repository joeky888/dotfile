Install
=====
* $ app-fast install unixodbc
* $ git clone --depth 1 https://github.com/rickbergfalk/sqlpad && cd sqlpad
* $ scripts/build.sh && cd server
* $ node server.js --dir ../db --port 3010 --base-url '/sqlpad' --admin "joeky@gmail.com" --passphrase  "joeky@gmail.com"
* Open localhost:3010/sqlpad and sign up with "joeky@gmail.com" "joeky"
* Login
* New Query -> DB connections -> Add connection

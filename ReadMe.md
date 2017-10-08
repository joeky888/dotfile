Install
====
```bash
curl -s https://raw.githubusercontent.com/j16180339887/dotfile/master/install.sh | bash
```

Install vimrc only
====
```bash
# Unix-like & Powershell: Use curl
curl https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc -o ~/.vimrc

# Unix-like: Use python2
python2 -c "import urllib; print urllib.urlopen('https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc'.encode('UTF-8')).read()" > ~/.vimrc

# Unix-like: Use python3
python3 -c "import urllib.request as ur; print (ur.urlopen('https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc').read().decode('utf-8'))" > ~/.vimrc

# Windows: Use cmd
C:\windows\explorer.exe https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc

# Windows: Use Powershell
Invoke-WebRequest "https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc" -OutFile "$ENV:UserProfile\\.vimrc"
```

Experience
=====
| Tool              |  Year        |
| ----------------- | ------------ |
| Windows           |  (2003-)     |
| Linux             |  (2014-)     |
| FreeBSD           |  (2017-)     |
| Git               |  (2014-)     |
| Bash              |  (2014-)     |
| Zsh               |  (2015-)     |
| Tmux              |  (2015-)     |
| Sublime Text      |  (2014-2015) |
| Adobe Brackets    |  (2015-2016) |
| Vim               |  (2016-)     |
| VSCode            |  (2016-)     |
| Cygwin            |  (2015-)     |
| Qt                |  (2014-)     |
| MS Office         |  (2010-2014) |
| Libre Office      |  (2014-2015) |
| WPS Office        |  (2015-)     |
| Chrome            |  (2010-2015) |
| Opera             |  (2015-)     |

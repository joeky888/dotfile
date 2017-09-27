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

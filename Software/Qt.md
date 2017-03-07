Install from archived (not recommend)
=====
* [archive]("https://download.qt.io/archive/online_installers/")

Install from git-for-windows/msys2
=====
```bash
pacman -Syu
pacman -S base-devel git mercurial cvs curl wget p7zip perl ruby python2 python3 mingw-w64-x86_64-toolchain
pacman -S mingw-w64-x86_64-qt5 mingw-w64-x86_64-qt-creator mingw-w64-x86_64-qt5-static
```

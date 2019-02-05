Install
=====
* $ pip install pyinstaller

Usage
=====
* Find which file has the Main function
* $ `grep -RiIn __main__`
```sh
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/Miniconda3/lib"
pyinstaller xxx.py
cd build
```

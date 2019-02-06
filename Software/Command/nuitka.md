Install
=====
* $ app-fast -S chrpath
* $ pip3 install nuitka

Usage
=====
* Find main file
* $ grep -RiIn main
* E.g `__main__.py`
* $ `nuitka3 --verbose --standalone --recurse-all --output-dir=/tmp/youtube-dl/build/exe __main__.py`

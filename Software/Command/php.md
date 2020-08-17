Install php and composer
=====
* $ app-fast -S composer

Enable common libs
=====
* $ sudoedit /etc/php/php.ini
```ini
extension=curl
extension=exif
extension=gd
extension=iconv
extension=swoole.so
extension=zip
```

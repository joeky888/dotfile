Download Mozilla certdata.txt and convert it to .crt
=====
* $ aria2c https://raw.githubusercontent.com/curl/curl/master/lib/mk-ca-bundle.pl && chmod +x mk-ca-bundle.pl
* $ ./mk-ca-bundle.pl
* Install the ca-bundle.crt file

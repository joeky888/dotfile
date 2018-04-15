Download Mozilla certdata.txt and convert it to .crt
=====
* $ aria2c https://raw.githubusercontent.com/curl/curl/master/lib/mk-ca-bundle.pl && chmod +x mk-ca-bundle.pl
* $ ./mk-ca-bundle.pl
* Install the ca-bundle.crt file

Convert multiple .pem files into one .pem file
=====
```sh
[[ -f ca-bundle.pem ]] && rm -f ca-bundle.pem || touch ca-bundle.pem
for cert in `ls *.pem`; do openssl x509 -text -in ${cert} >> ca-bundle.pem; done
```

Convert .pem to .crt
=====
```sh
openssl x509 -in input.pem -inform PEM -out output.crt
```

View a .crt file
=====
```sh
openssl x509 -in input.crt -text -noout
```

Install .crt to debian and ubuntu
=====
```sh
# Debian and Ubuntu
sudo mkdir -p /usr/share/ca-certificates/extra
sudo cp asus.com.crt /usr/share/ca-certificates/extra/asus.com.crt
sudo dpkg-reconfigure ca-certificates # Make sure asus is selected
sudo update-ca-certificates

# Manjaro and Arch
sudo cp asus.com.crt /etc/ca-certificates/trust-source/anchors/asus.com.crt
sudo cat asus.com.crt >> /etc/ssl/certs/ca-certificates.crt
sudo trust extract-compat
sudo update-ca-trust extract
```

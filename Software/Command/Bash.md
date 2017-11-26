Change owner to root
=====
* $ sudo chown root:root /Somewhere/file
* $ sudo chown -R root:root /Somewhere/folder

Change owner to currnet user
=====
* Known user
* $ sudo chown joeky:joeky /Somewhere/file
* Unknown user for general purpose
* $ sudo chown ${USER:=$(/usr/bin/id -run)}:$USER /Somewhere/file
* $ sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER /Somewhere/folder

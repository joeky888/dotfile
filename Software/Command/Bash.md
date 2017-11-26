Change owner to root
=====
* $ sudo chown root:root /Somewhere/file
* $ sudo chown -R root:root /Somewhere/folder

Change owner to currnet user
=====
* $ sudo chown ${USER:=$(/usr/bin/id -run)}:$USER /Somewhere/file
* $ sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER /Somewhere/folder

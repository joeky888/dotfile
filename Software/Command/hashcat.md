Install
=====
* Install nvidia driver (with opencl headers)

Crack md5 string
=====
* $ echo -n joeky | md5sum # Get "31867c976c4cb7aab64561206d848db9"
* $ hashcat -m 0 -a 3 "31867c976c4cb7aab64561206d848db9"
* $ hashcat --show -m 0 -a 3 "31867c976c4cb7aab64561206d848db9" # Output joeky
* -m 0 Means md5
* -a 3 Means mode=brute-force

Crack hash file "password.txt" with php bcrypt content
=====
* $ hashcat -m 3200 -a 0 password.txt /usr/share/doc/hashcat/example.dict
* $ hashcat --show -m 3200 -a 0 password.txt /usr/share/doc/hashcat/example.dict # Output password
* -m 3200 Means bcrypt sha1 mode
* -a 0 Means mode = dict


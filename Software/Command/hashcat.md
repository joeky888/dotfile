Install
=====
* Install nvidia driver (with opencl headers)

Crack hash string
=====
* $ echo -n joeky | md5sum # Get "31867c976c4cb7aab64561206d848db9"
* $ hashcat -m 0 -a 3 "31867c976c4cb7aab64561206d848db9"
* $ hashcat --show -m 0 -a 3 "31867c976c4cb7aab64561206d848db9" # Output joeky
* -m 0 Means md5
* -a 3 Means mode=brute-force

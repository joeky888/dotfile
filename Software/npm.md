Local nested dependencies
=====
* B include A
* C include B
* C > B > A
* A packed into A.tgz (npm pack)
* B packed into B.tgz (npm pack) and has a dependency A.tgz
* C must include both A.tgz and B.tgz in order to use B

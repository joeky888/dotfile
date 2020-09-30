Build a program which get better support for gdb
=====
* $ gcc -g a.cpp

Stack trace a crashed program
====
* $ gdb a.exe
* (gdb) run
* (gdb) run # Keep running until it is crashed
* (gdb) bt full

Start gdb
=====
* $ gdb -tui a.exe
* Set a break point on line 10 and display its value
* (gdb) run
* (gdb) break 10
* (gdb) display VARIABLENAME
* (gdb) quit

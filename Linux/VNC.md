Setup VNC server
=====
* $ sudo apt-fast install tightvncserver
* $ vncserver

Reset password
=====
* $ rm ~/.vnc/passwd

Client
=====
* The easiest one is to install Chrome APP VNC Viewer
* Or
* $ sudo apt-fast install tigervnc-viewer
* Connect to the host
    * 192.168.0.1:5901 # Try 5902~5910, or use nmap to scan open port

Kill VNC server
=====
* $ vnc4server -kill :1 # Or :2 :3

After installed
=====
* Setting -> Power Management -> Disable computer auto sleeping
* Setting -> Account -> auto login
* $ sudoedit /etc/apt/sources.list -> Use "unstable"
```debsources
deb [by-hash=force] http://ftp.ubuntu-tw.org/mirror/deepin/ unstable main contrib non-free universe
```

Theme
=====
* Terminal theme
    * Click setting button -> Switch theme -> elementary
* Dock theme
    * Right click on the dock -> Mode -> Efficient Mode

Packages
=====
* These pakcages are more powerful if they are installed from deepin GUI store
* $ sudo apt-fast install opera-developer opera-stable deepin-system-monitor deepin.com.baidu.pan -y # Probably missing some icons if using cli to install them

Nvidia driver
=====
* $ `sudo apt remove nvidia-* -y`
* $ sudo apt-get install bumblebee-nvidia nvidia-driver nvidia-settings -y
* Check driver is installed successfully
* $ sudo apt-fast install mesa-utils -y
* $ optirun glxinfo | grep NVIDIA
* $ optirun glxgears -info # Test bumblebee
* Open a program with Nvidia driver, Ex: firefox
    * $ Primusrun firefox
    * Or
    * $ optirun firefox
* If error "You do not appear to be using the NVIDIA X driver" appears
    * $ optirun -b none nvidia-settings -c :8

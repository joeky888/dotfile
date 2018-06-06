Python env location
=====
* File -> Settings -> Project xxx -> Project Interpreter -> Add new interpreter manually (On the top)

Code Completion
=====
* File -> Settings -> Editor -> General -> Code Completion
    * Case sensitive completion -> None

Keymapping
=====
* See AndroidStudio.md

Colored logcat
=====
* Preferences –> Editor –> Colors Scheme –> Console Colors -> Log Console
```conf
Material design palette (Weak):
    Error           : EF5350
    Expired entry   : 66BB6A
    Warn            : FFC107

Material design palette (Strong):
    Error           : F44336
    Expired entry   : 4CAF50
    Warning         : FFC107

Darcula palette:
    Error           : FF6B68
    Expired entry   : 6A8759
    Warn            : BBB529
```

If Run -> Run(or Debug) is grayed out (不能點)
=====
* Right click on the target .py file -> Select Run

Run a module command
=====
* Command
* $ python3 -m train.train --epochs 30
* Pycharm Run configuration (find runpy.py)
    * Script: ~/Miniconda3/lib/python3.6/runpy.py
    * Script parameters: train.train --epochs 30
    * Interpreter options: (leave blank, no -m required)

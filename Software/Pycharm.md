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

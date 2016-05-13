'''
Put this file to python site-packages folder
Check the site-packages folder location
    $ python3
    >>> import site; site.getsitepackages()
Put this file under site-packages folder
'''

import sys
sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf8', buffering=1)
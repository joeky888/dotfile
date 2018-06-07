Remove all invisible characters
=====
```python
string.strip(' \t\n\r')
```

Raise an error
=====
```python
try:
    SystemLanguageCode, SystemEncoding = locale.getdefaultlocale()
except ValueError as e:
    if e.args and e.args[0] and e.args[0] == "unknown locale: UTF-8":
        SystemLanguageCode, SystemEncoding = '', 'UTF-8'
    else:
        raise # Throw this error again
```

Debugging preprocessor
=====
* $ python -O abc.py # Debug off
* $ python abc.py # Debug on
```python
if __debug__:
    print 'Debug ON'
else:
    print 'Debug OFF'
```

Terminal color
=====
```python
BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)
RESET = '\033[0m'

def termcolor(fg=None, bg=None):
  codes = []
  if fg is not None: codes.append('3%d' % fg)
  if bg is not None: codes.append('10%d' % bg)
  return '\033[%sm' % ';'.join(codes) if codes else ''

def colorize(message, fg=None, bg=None):
  return termcolor(fg, bg) + message + RESET

print(colorize("hi", WHITE, BLACK))
```

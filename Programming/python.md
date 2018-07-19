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

Cross-platform terminal colors using unicode
=====
```python
print("\u001b[30mTEXT\u001b[39m")
print("\u001b[31mTEXT\u001b[39m")
print("\u001b[32mTEXT\u001b[39m")
print("\u001b[33mTEXT\u001b[39m")
print("\u001b[34mTEXT\u001b[39m")
print("\u001b[35mTEXT\u001b[39m")
print("\u001b[36mTEXT\u001b[39m")
print("\u001b[37mTEXT\u001b[39m")
print("\u001b[90mTEXT\u001b[39m")
print("\u001b[91mTEXT\u001b[39m")
print("\u001b[92mTEXT\u001b[39m")
print("\u001b[93mTEXT\u001b[39m")
print("\u001b[94mTEXT\u001b[39m")
print("\u001b[95mTEXT\u001b[39m")
print("\u001b[96mTEXT\u001b[39m")
print("\u001b[97mTEXT\u001b[39m")

print("\u001b[40mTEXT\u001b[49m")
print("\u001b[41mTEXT\u001b[49m")
print("\u001b[42mTEXT\u001b[49m")
print("\u001b[43mTEXT\u001b[49m")
print("\u001b[44mTEXT\u001b[49m")
print("\u001b[45mTEXT\u001b[49m")
print("\u001b[46mTEXT\u001b[49m")
print("\u001b[47mTEXT\u001b[49m")
print("\u001b[100mTEXT\u001b[49m")
print("\u001b[101mTEXT\u001b[49m")
print("\u001b[102mTEXT\u001b[49m")
print("\u001b[103mTEXT\u001b[49m")
print("\u001b[104mTEXT\u001b[49m")
print("\u001b[105mTEXT\u001b[49m")
print("\u001b[106mTEXT\u001b[49m")
print("\u001b[107mTEXT\u001b[49m")
```

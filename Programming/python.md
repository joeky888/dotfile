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

Parsing a comma-separated list of numbers and range specifications
=====
* https://gist.github.com/kgaughan/2491663
```python
from itertools import chain

def parse_range(rng):
    parts = rng.split('-')
    if 1 > len(parts) > 2:
        raise ValueError("Bad range: '%s'" % (rng,))
    parts = [int(i) for i in parts]
    start = parts[0]
    end = start if len(parts) == 1 else parts[1]
    if start > end:
        end, start = start, end
    return range(start, end + 1)

def parse_range_list(rngs):
    return sorted(set(chain(*[parse_range(rng) for rng in rngs.split(',')])))
```

Cross-platform terminal colors using unicode
=====
```python
print("\u001b[30mTEXT30\u001b[39m")
print("\u001b[31mTEXT31\u001b[39m")
print("\u001b[32mTEXT32\u001b[39m")
print("\u001b[33mTEXT33\u001b[39m")
print("\u001b[34mTEXT34\u001b[39m")
print("\u001b[35mTEXT35\u001b[39m")
print("\u001b[36mTEXT36\u001b[39m")
print("\u001b[37mTEXT37\u001b[39m")
print("\u001b[90mTEXT90\u001b[39m")
print("\u001b[91mTEXT91\u001b[39m")
print("\u001b[92mTEXT92\u001b[39m")
print("\u001b[93mTEXT93\u001b[39m")
print("\u001b[94mTEXT94\u001b[39m")
print("\u001b[95mTEXT95\u001b[39m")
print("\u001b[96mTEXT96\u001b[39m")
print("\u001b[97mTEXT97\u001b[39m")

print("\u001b[40mTEXT40\u001b[49m")
print("\u001b[41mTEXT41\u001b[49m")
print("\u001b[42mTEXT42\u001b[49m")
print("\u001b[43mTEXT43\u001b[49m")
print("\u001b[44mTEXT44\u001b[49m")
print("\u001b[45mTEXT45\u001b[49m")
print("\u001b[46mTEXT46\u001b[49m")
print("\u001b[47mTEXT47\u001b[49m")
print("\u001b[100mTEXT100\u001b[49m")
print("\u001b[101mTEXT101\u001b[49m")
print("\u001b[102mTEXT102\u001b[49m")
print("\u001b[103mTEXT103\u001b[49m")
print("\u001b[104mTEXT104\u001b[49m")
print("\u001b[105mTEXT105\u001b[49m")
print("\u001b[106mTEXT106\u001b[49m")
print("\u001b[107mTEXT107\u001b[49m")
```

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

Debug preprocessor
=====
* $ python -O abc.py # Debug off
* $ python abc.py # Debug on
```
if __debug__:
    print 'Debug ON'
else:
    print 'Debug OFF'

```

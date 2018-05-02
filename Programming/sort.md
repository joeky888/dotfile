Single loop sorting
=====
```javascript
var a = [5, 6, 3, 4, 1, 9]

for (var i = 0; i < a.length-1; i++)
    if (i >= 0 && a[i] > a[i+1]) {
        temp=a[i]; a[i]=a[i+1]; a[i+1]=temp
        i-=2
    }

console.log(a)
```
```python
a = [5, 6, 3, 4, 1, 9]
i = 0

while i < len(a)-1:
    if i >= 0 and a[i] > a[i+1]:
        a[i], a[i+1] = a[i+1], a[i]
        i -= 2
    i += 1

print(a)
```

Single loop sorting
=====
```cpp
for (i = 0; i < arr.length-1 && i >=0; i++)
    if (arr[i] > arr[i+1]) {
        swap(arr[i], arr[i+1]); i-=2
    }
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

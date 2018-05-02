Single loop sorting
=====
```c
for (i = 0; i < arr.length-1 && i >=0; i++)
    if (arr[i] > arr[i+1])
        swap(arr[i], arr[i+1]); i-=2
```

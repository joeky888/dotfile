## Swap using macro
=====
* Integer only
```c
#ifndef SWAP(x, y)
#define SWAP(x, y) int tmp = x; x = y; y = tmp;
#endif
```

## Generic swap macro in C method 1
=====
```c
#define swap(x,y) do \
   { unsigned char swap_temp[sizeof(x) == sizeof(y) ? (signed)sizeof(x) : -1]; \
     memcpy(swap_temp,&y,sizeof(x)); \
     memcpy(&y,&x,       sizeof(x)); \
     memcpy(&x,swap_temp,sizeof(x)); \
    } while(0)
```

## Generic swap macro in C method 2
=====
```c
#define SWAP(x, y, T) do { T SWAP = x; x = y; y = SWAP; } while (0)
```

## Quick sort method 1
=====
```c
void quicksort(int *data, int left, int right)
{
    int pivot, i, j;

    if (left >= right) { return; }

    pivot = data[left];

    i = left + 1;
    j = right;

    while (1)
    {
        while (i <= right)
        {
            if (data[i] > pivot)
            {
                break;
            }

            i = i + 1;
        }

        while (j > left)
        {
            if (data[j] < pivot)
            {
                break;
            }

            j = j - 1;
        }

        if (i > j) { break; }

        swap(&data[i], &data[j]);
    }

    swap(&data[left], &data[j]);

    quicksort(data, left, j - 1);
    quicksort(data, j + 1, right);
}
```
## Quick sort method 2
=====
```c
void quickSort( int a[], int l, int r)
{
   int j;

   if( l < r )
   {
        // divide and conquer
        j = partition( a, l, r);
        quickSort( a, l, j-1);
        quickSort( a, j+1, r);
   }

}



int partition( int a[], int l, int r) {
   int pivot, i, j, t;
   pivot = a[l];
   i = l; j = r+1;

   while( 1)
   {
        do ++i; while( a[i] <= pivot && i <= r );
        do --j; while( a[j] > pivot );
        if( i >= j ) break;
        t = a[i]; a[i] = a[j]; a[j] = t;
   }
   t = a[l]; a[l] = a[j]; a[j] = t;
   return j;
}
```

Find max number with unknown function variable lenth
=====
```c
#include <stdarg.h>

int maxof(int n_args, ...)
{
    va_list ap;
    va_start(ap, n_args);
    int max = va_arg(ap, int);
    for(int i = 2; i <= n_args; i++) {
        int a = va_arg(ap, int);
        if(a > max) max = a;
    }
    va_end(ap);
    return max;
}
```

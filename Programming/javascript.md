Map reduce
=====
```javascript
var myArr = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];

var result = myArr
    .map(function(element) {
        // 數值大於五的數值視為五
        if (element > 5)
            return 5;

        return element;
    })
    .reduce(function(prev, element) {
        // 與之前的數值加總，回傳後代入下一輪的處理
        return prev + element;
    }, 0);

console.log(result); // 40
```

ES6+
=====
* Map with Arrow Function
```javascript
let newArr = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ].map((value) => value + 1);
```

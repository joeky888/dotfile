Get browser user agent
=====
```javascript
var agent = navigator.userAgent || navigator.vendor || window.opera;
console.log(agent);
```

Print colored JSON without libs
=====
* Use `util.inspect.colors` to change different colors
* Use `util.inspect.styles` to change different colors for each keyword
```javascript
util.inspect(JSON.parse('{"foo":"bar"}'), false, null, true)
util.inspect(myObject, false, null, true)
```

Foreach loop, index vs element
=====
```javascript
let list = ["a", "b", "c"];

for (let i in list) {
   console.log(i); // "0", "1", "2",
}

for (let i of list) {
   console.log(i); // "a", "b", "c"
}
```

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

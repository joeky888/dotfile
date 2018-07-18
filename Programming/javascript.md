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

// Quick example
const util = require('util')
util.inspect(JSON.parse('{"foo":"bar"}'), false, null, true)
util.inspect(myObject, false, null, true)

// Test all colors
for (var i = 0; i < 128; i++) {
    util.inspect.styles.name = 'lightmagenta';
    util.inspect.colors.lightmagenta = [i,39];
    console.log("i = " + i)
    console.log(util.inspect(JSON.parse('{"firstName": "John","lastName": "Smith","isAlive": true,"age": 27,"address": {"streetAddress": "21 2nd Street","city": "New York","state": "NY","postalCode": "10021-3100"},"phoneNumbers": [{"type": "home","number": "212 555-1234"},{"type": "office","number": "646 555-4567"},{"type": "mobile","number": "123 456-7890"}],"children": [],"spouse": null}'),false, 10, true))
}

util.inspect.colors.RED=[31,39]
util.inspect.colors.GREEN=[32,39]
util.inspect.colors.YELLOW=[33,39]
util.inspect.colors.BLUE=[34,39]
util.inspect.colors.PURPLE=[35,39]
util.inspect.colors.CYAN=[36,39]
util.inspect.colors.GRAY=[30,39]
util.inspect.colors.LIGHT_RED=[91,39]
util.inspect.colors.LIGHT_GREEN=[92,39]
util.inspect.colors.LIGHT_YELLOW=[93,39]
util.inspect.colors.LIGHT_BLUE=[94,39]
util.inspect.colors.LIGHT_PURPLE=[95,39]
util.inspect.colors.LIGHT_CYAN=[96,39]
util.inspect.colors.LIGHT_GRAY=[97,39]

util.inspect.styles.name='LIGHT_CYAN'
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

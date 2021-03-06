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
util.inspect.colors.GRAY=[90,39]
util.inspect.colors.LIGHT_RED=[91,39]
util.inspect.colors.LIGHT_GREEN=[92,39]
util.inspect.colors.LIGHT_YELLOW=[93,39]
util.inspect.colors.LIGHT_BLUE=[94,39]
util.inspect.colors.LIGHT_PURPLE=[95,39]
util.inspect.colors.LIGHT_CYAN=[96,39]
util.inspect.colors.LIGHT_GRAY=[97,39]

util.inspect.colors.BG_RED=[41,49]
util.inspect.colors.BG_GREEN=[42,49]
util.inspect.colors.BG_YELLOW=[44,49]
util.inspect.colors.BG_BLUE=[44,49]
util.inspect.colors.BG_PURPLE=[45,49]
util.inspect.colors.BG_CYAN=[46,49]
util.inspect.colors.BG_GRAY=[90,39]
util.inspect.colors.BG_LIGHT_RED=[101,49]
util.inspect.colors.BG_LIGHT_GREEN=[102,49]
util.inspect.colors.BG_LIGHT_YELLOW=[103,49]
util.inspect.colors.BG_LIGHT_BLUE=[104,49]
util.inspect.colors.BG_LIGHT_PURPLE=[105,39]
util.inspect.colors.BG_LIGHT_CYAN=[106,49]
util.inspect.colors.BG_LIGHT_GRAY=[107,49]

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
* Get data from a promise object
```javascript
const result = await async myPromiseFunc
// Or
const result  = await myPromiseFunc.then(result => result.data);
```

String color
=====
```javascript
exports.logcat = function() {
    String.prototype.RED            = function(){ return `\u001b[31m${this}\u001b[39m` }
    String.prototype.GREEN          = function(){ return `\u001b[32m${this}\u001b[39m` }
    String.prototype.YELLOW         = function(){ return `\u001b[33m${this}\u001b[39m` }
    String.prototype.BLUE           = function(){ return `\u001b[34m${this}\u001b[39m` }
    String.prototype.PURPLE         = function(){ return `\u001b[35m${this}\u001b[39m` }
    String.prototype.CYAN           = function(){ return `\u001b[36m${this}\u001b[39m` }
    String.prototype.GRAY           = function(){ return `\u001b[37m${this}\u001b[39m` }
    String.prototype.LIGHT_RED      = function(){ return `\u001b[91m${this}\u001b[39m` }
    String.prototype.LIGHT_GREEN    = function(){ return `\u001b[92m${this}\u001b[39m` }
    String.prototype.LIGHT_YELLOW   = function(){ return `\u001b[93m${this}\u001b[39m` }
    String.prototype.LIGHT_BLUE     = function(){ return `\u001b[94m${this}\u001b[39m` }
    String.prototype.LIGHT_PURPLE   = function(){ return `\u001b[95m${this}\u001b[39m` }
    String.prototype.LIGHT_CYAN     = function(){ return `\u001b[96m${this}\u001b[39m` }
    String.prototype.LIGHT_GRAY     = function(){ return `\u001b[97m${this}\u001b[39m` }
}
```

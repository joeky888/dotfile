Vscode
=====
* Install flutter and add flutter/bin to PATH
* Install vscode flutter plugin
* Add launch.json
```js
{
    "name": "Flutter run",
    "type": "dart",
    "request": "launch",
    "program": "lib/main.dart"
},
{
    "name": "Flutter: Attach to Device",
    "type": "dart",
    "request": "attach"
}
```

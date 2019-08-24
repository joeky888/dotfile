Docker
=====
* $ docker run --name flutter -it cirrusci/flutter bash
    * $ sudo chown cirrus:cirrus -R /home/cirrus/
* $ docker cp flutter-app flutter:/home/cirrus
* $ flutter packages get
* $ flutter pub get
* $ flutter build apk --release

List dependencies
=====
* $ flutter packages pub deps

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

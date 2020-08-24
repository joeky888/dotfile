Docker
=====
* $ docker run --name flutter -p 8080:8080 -it cirrusci/flutter bash
    * $ sudo chown cirrus:cirrus -R /home/cirrus/
* $ docker cp flutter-app flutter:/home/cirrus
* $ flutter packages get
* $ flutter pub get
* $ flutter run
* $ flutter build apk --release

List dependencies
=====
* $ flutter packages pub deps

Set channel
=====
* $ flutter channel stable # Set to stable
* $ flutter channel beta   # Set to beta
* $ flutter channel dev    # Set to dev
* $ flutter upgrade

New project
=====
* $ flutter create projectname

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
    "program": "lib/main.dart" // Make sure there is NO string like "flutter_web" in pubspec.yaml
},
{
    "name": "Flutter: Attach to Device",
    "type": "dart",
    "request": "attach" // Don't use attach mode. launch mode can run on VM and physical devices
}
```

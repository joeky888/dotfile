Install
=====
* Install Xcode
* Run Xcode to complete installation (first time only)
* $ sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
* $ npm install -g ios-sim
* $ npm install -g ios-deploy
* $ npm install -g cordova

New project
=====
* $ cordova create hello com.joeky.hello "HelloWorld"
* $ cd hello
* $ rm -rf www; cp -r path/to/myweb www
* $ cordova platform remove ios; cordova platform add https://github.com/apache/cordova-ios.git
* $ cordova prepare
* Use Xcode to open ./platforms/ios/xxx.xcodeproj
    * Select project name from file tree (on the left) -> General -> Team -> Joeky Zhan (Personal Team)
* $ cordova run ios --device # Or cordova emulate ios
* iOS device setting -> General -> Trust joeky's email

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
* $ cordova create hello com.example.hello "HelloWorld"
* $ cd hello
* $ cordova platform remove ios; cordova platform add https://github.com/apache/cordova-ios.git
* $ cordova prepare
* $ cordova run ios --device # Or cordova emulate ios

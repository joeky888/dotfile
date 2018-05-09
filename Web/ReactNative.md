Install with npm
=====
* Download nodejs LTS, because the latest version isn't always compatible with RN
* $ npm install -g create-react-native-app
* Install watchman (https://github.com/facebook/watchman)
* Install Android Studio, JDK and python2

Install with yarn
=====
* $ npm install -g yarn
* $ yarn global add create-react-native-app

Init
======
* Install Expo app and open the project
* $ create-react-native-app ProjectName
* $ cd ProjectName
* $ `rm -rf node_modules`
* $ yarn install
* Disable all other connetions in Network Connections (Like "VirtualBox Host-Only Network")
* $ npm --verbose start
* $ npm --verbose run android
* $ npm --verbose run ios
* Press capital `R` in terminal to restart and clear cache

Run with vscode
=====
* $ npm install -g react-native-cli
* $ react-native init myapp && cd myapp
* Install `React Native Tools` vscode extension
* Open myapp using vscode

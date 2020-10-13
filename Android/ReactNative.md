Install with npm
=====
* Download nodejs LTS, because the latest version isn't always compatible with RN
* $ npm install -g expo-cli react-native-cli
* Install watchman (https://github.com/facebook/watchman)
    * $ yaourt -S watchman
* $ react-native doctor

Init
======
* Install Expo app and open the project
* Make sure all other Network interfaces/Firewall are disabled
* $ expo init ProjectName
* $ cd ProjectName
* $ `rm -rf node_modules`
* $ npm install && npm audit fix --force
* Disable all other connetions in Network Connections (Like "VirtualBox Host-Only Network")
* $ `echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_watches && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_queued_events && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_instances && watchman shutdown-server && sudo sysctl -p`
* $ `sudo sysctl -w fs.inotify.max_user_watches=10000`
* $ watchman watch-del-all ; rm -f package-lock.json yarn.lock ; npm --verbose --reset-cache start # then press Q
* $ npm run android
* $ npm run ios
* Press capital `R` in terminal to restart and clear cache

Upgrade expo and react-native
=====
* $ cd project && expo upgrade

Build Android apk
=====
* Method 1: Offline
    * $ vim package.json
        * Edit package.json and set react-native to latest version like `0.58.0`
    * $ expo eject
    * $ `rm -rf node_modules && npm i`
    * $ vim index.js
```js
import { AppRegistry } from "react-native"
import App from "./App"
import { name as appName } from "./app.json"
AppRegistry.registerComponent(appName, () => App)
```
    * Make sure AppName in app.json is correct! Like this
```json
{
    "name": "RssNewsMan",
    "displayName": "RssNewsMan",
    "expo": {
        "name": "RssNewsMan"
    }
}
```
    * $ npm i --save-dev scheduler
    * $ mkdir android/app/src/main/assets
    * $ react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res
    * Open android folder and Build with Android studio
        * File -> Invalidate Caches/Restart
* Method 2: Expo online
    * $ expo ba # Or expo build:android

Push app to the store (TODO)
=====
* Use Microsoft/react-native-code-push

Debug in vscode (using attach mode)
=====
```js
{
            "name": "Debug in Exponent",
            "cwd": "${workspaceFolder}",
            "type": "reactnative",
            "request": "launch",
            "platform": "exponent"
        }
```
* Shake phone -> Select "Debug JS Remotely"
* Stop -> Stop debugger in vscode -> $ killall ngrok node

Html vs React Native
=====
```html
              <div> | <View> or <KeyboardAvoidingView>
             <span> | <Text>
<input type="text"> | <TextInput>
           <button> | <TouchableOpacity> or <Button>
              <img> | <Image>
           <ul><li> | <ListView>
```

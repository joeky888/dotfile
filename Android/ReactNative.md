Install with npm
=====
* Download nodejs LTS, because the latest version isn't always compatible with RN
* $ npm install -g create-react-native-app
* Install watchman (https://github.com/facebook/watchman)
    * $ yaourt -S watchman
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
* $ npm install && npm audit fix --force # or yarn install
* Disable all other connetions in Network Connections (Like "VirtualBox Host-Only Network")
* $ `echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_watches && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_queued_events && echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_instances && watchman shutdown-server && sudo sysctl -p`
* $ `sudo sysctl -w fs.inotify.max_user_watches=10000`
* $ watchman watch-del-all ; rm -f package-lock.json yarn.lock ; npm --verbose --reset-cache start # then press Q
* $ npm --verbose run android
* $ npm --verbose run ios
* Press capital `R` in terminal to restart and clear cache
* $ cd .. && react-native init ProjectName # Ejecting Expo, Create android and ios folder

Run with vscode
=====
* $ npm install -g react-native-cli
* $ react-native init myapp && cd myapp
* Upgrade gradle
    * Edit myapp/android/build.gradle
```js
repositories {
    google()
    jcenter()
    mavenCentral()
    dependencies {
        classpath 'com.android.tools.build:gradle:3.1.0'
    }
}
```
    * Edit myapp/android/gradle/wrapper/gradle-wrapper.properties
```conf
distributionUrl=https\://services.gradle.org/distributions/gradle-4.4.1-all.zip
```
* Install `React Native Tools` `React Native snippets` vscode extension
* Open myapp using vscode
* Create `.vscode/tasks.json` to build .apk or .ipa
    * Add `JAVA_HOME` and `ANDROID_HOME` to tasks.json (also setting $PATH)
    * One can also add proxy in the tasks.json, like this
        * `./gradlew -Dhttp.proxyHost=10.78.20.186 -Dhttp.proxyPort=3128 -Dhttps.proxyHost=10.78.20.186 -Dhttps.proxyPort=3129 -Dhttps.proxyUser=kungfu -Dhttps.proxyPassword=howkungfu`
```json
"taskName": "Build APK Release",
"linux": {
    "command": "export ANDROID_HOME=$HOME/Android/Sdk && export JAVA_HOME=$HOME/zulu && export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH && cd android && ./gradlew assembleRelease"
}
```
* vscode -> Tasks -> Run Task, apk will be located here `myapp/android/app/build/outputs/apk`
* Add a new task for running apk on devices
```json
"taskName": "Install and Run APK Debug",
"linux": {
    "command": "cd android && ./gradlew installDebug"
}

,
"taskName": "Install and Run APK Release",
"linux": {
    "command": "adb install -d android/app/build/outputs/apk/app-release-unsigned.apk"
}
```

Push app to the store (TODO)
=====
* Use Microsoft/react-native-code-push

Html vs React Native
=====
```html
              <div> | <View>
             <span> | <Text>
<input type="text"> | <InputText>
           <button> | <Button>
             <img>  | <Image>
```

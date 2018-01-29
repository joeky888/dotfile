Make build faster
=====
* File -> Settings -> Build, Execution, Deployment -> Build Tools -> Gradle -> Global Gradle settings -> Offline work -> Check
* Edit gradle.properties file, add
```conf
org.gradle.daemon=true
org.gradle.parallel=true
```
* Disable proxy if downloading dependencies takes forever

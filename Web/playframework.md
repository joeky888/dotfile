Create an app by using intellij(not recommended)
=====
* $ activator new myapp play-java
* $ cd myapp
* Using intellij(with scala plugin installed) import myapp as sbt project
* $ activator clean
* $ activator compile
* Using intellij run

Create an app by using eclipse
=====
* Install Eclipse Java EE IDE for Web Developers
* Open Eclipse -> Help -> Install New Software -> Add -> Name:Scala IDE, Location:(see http://scala-ide.org/download/current.html or http://scala-ide.org/download/nightly.html) -> OK
* $ activator new myapp play-java
* Add 'addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "5.0.1")' to myapp/project/plugins.sbt
* $ cd myapp
* $ activator clean
* $ activator compile
* $ activator eclipse
* Using Eclipse(with Scala IDE installed) import -> General -> Existing Projects into Workspace -> myapp

Run app
=====
* $ cd myapp
* Reload on refreshing webpage
* $ activator "~run 80"

Debug using eclipse
=====
* $ activator -jvm-debug 9999 "run 80"
* Right click project -> Debug As -> Debug Configuration -> Remote Java Application -> Right Click and new -> change port to 9999 -> Debug
* After debugging, press Ctrl-F8 to change ui back

Refresh if eclipse does not recognize some symbols
=====
* $ activator clean
* $ activator compile
* $ activator eclipse
* Start with "eclipse.exe -clean"
* Right click and select refresh(F5) OR Right click and select Close Project and import it again

Eclipse setting
=====
* eclipse.ini set java stack size
* Window > Preferences > Java > Editor > Content Assist
* Auto Activation > Auto activation triggers for Java
* Enter "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ._" instead of "."
* Window > Preferences > General > Appearance > Use Dark theme

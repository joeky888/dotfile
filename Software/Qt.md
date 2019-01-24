Install from archived (not recommend)
=====
* [archive]("https://download.qt.io/archive/")

Install from git-for-windows/msys2
=====
```sh
pacman -Syu
pacman -S base-devel git mercurial cvs curl wget p7zip perl ruby python2 python3 mingw-w64-x86_64-toolchain
pacman -S mingw-w64-x86_64-qt5 mingw-w64-x86_64-qt-creator mingw-w64-x86_64-qt5-static
```

Error: at least one valid and enable repository required for this action to succeed
=====
* Open Maintain tool -> Settings -> Repositories -> User defined repositories -> Add ->
```markdown
"http://download.qt.io/online/qtsdkrepository/windows_x86/desktop/tools_maintenance/"
"http://download.qt.io/online/qtsdkrepository/windows_x86/root/qt/"
```

Qt Creator
=====
* Tools -> Options -> Environment -> Keyboard
```xml
<shortcut id="TextEditor.CopyLineDown"><key value="Ctrl+D"/></shortcut>
<shortcut id="TextEditor.UnCommentSelection"><key value="Ctrl+\"/></shortcut>
<shortcut id="TextEditor.DeleteLine"/><key value="Ctrl+K"/></shortcut>
<shortcut id="TextEditor.GotoLineEnd"/><key value="Ctrl+E"/></shortcut>
<shortcut id="TextEditor.GotoLineStart"/><key value="Ctrl+A"/></shortcut>
<shortcut id="QtCreator.SelectAll"><key value="Ctrl+G"/></shortcut>
<shortcut id="TextEditor.MoveLineUp"><key value="Ctrl+U"/></shortcut>
<shortcut id="TextEditor.MoveLineDown"><key value="Ctrl+J"/></shortcut>
<shortcut id="TextEditor.viewLineUp"><key value="Ctrl+Up"/></shortcut>
<shortcut id="TextEditor.viewPageDown"><key value="Ctrl+Down"/></shortcut>
```

Windeployqt
=====
* Open Qt cmd.exe
* cd $ReleaseFolder
* windeployqt .
* If using qml, then
* windeployqt --qmldir <PathToQml> .

Static build on Windows mingw
=====
* Reference <https://wiki.qt.io/How_to_build_a_static_Qt_version_for_Windows_with_gcc>
* Install qt with mingw tool and python3
* Download source and extract as "qt-everywhere-opensource-src-5" folder name
* Edit qt-everywhere-opensource-src-5\qtbase\mkspecs\win32-g++\qmake.conf
```conf
QMAKE_LFLAGS     = -static
QMAKE_LFLAGS_DLL = -static
DEFINES          = QT_STATIC_BUILD
```
* Edit qt-everywhere-opensource-src-5\qmake\Makefile.win32
```conf
LFLAGS = -static
```
* Open Qt cmd, see more options by using `configure.bat --help`
```sh
# I got an error on this, to be continue...
configure.bat -prefix "c:\QT\Qt5-static" -static -release -ltcg -optimize-size -opensource -confirm-license -platform win32-g++ -qt-zlib -qt-libpng -qt-libjpeg -gif -ico -opengl desktop -qt-pcre -qt-freetype -nomake tests -nomake examples -no-compile-examples -skip qtdeclarative -skip qtwebengine
mingw32-make
mingw32-make install
```

Use latest MinGW-w64 with cmake (For non-Qt project)
=====
* $ choco install cmake.portable -y # Make sure cmake is in the $PATH
* Download MinGW-w64 with posix and seh
* Extract MinGW-w64 to C:\mingw64
* Qt creator -> Tool -> Options -> Build and Run
    * Compilers
        * Add -> MinGW ->  C  -> Compiler path -> C:\mingw64\bin\x86_64-w64-mingw32-gcc.exe
        * Add -> MinGW -> C++ -> Compiler path -> C:\mingw64\bin\x86_64-w64-mingw32-g++.exe
    * Debuggers
        * Add -> path -> C:\mingw64\bin\gdb.exe
    * Kits
        * Compiler  C  -> MinGW
        * Compiler C++ -> MinGW
        * Debugger -> GDB
        * Cmake Tool -> C:\ProgramData\chocolatey\bin\cmake.exe
        * Cmake generator -> Change -> Generator -> MinGW Makefiles
        * Cmake Configuration -> Change -> Add this -> CMAKE_MAKE_PROGRAM:INTERNAL=C:\mingw64\bin\mingw32-make.exe
* Example
```cmake
cmake_minimum_required(VERSION 2.8)
SET(CMAKE_CXX_FLAGS  "-static-libgcc -static-libstdc++ -static")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
project(wxcmake)
aux_source_directory(. SRC_LIST)
add_executable(${PROJECT_NAME} "main.cpp")
target_link_libraries(${PROJECT_NAME} ${LIB_DIR}/thirdParty.a zlib glfw glxw)
```

Android
=====
* Install Android SDK by using Android Studio (recommend)
* Or use Qt Creator -> Tools -> Options -> Devices -> Android -> SDK manager
* Or just use sdkmanager.bat
* $ `C:\Android\SDK\bin\sdkmanager.bat --list --verbose`
* $ `C:\Android\SDK\bin\sdkmanager.bat --sdk_root=C:\Android\SDK "platform-tools" "tools" "platforms;android-27" "build-tools;27.0.3" "extras;google;m2repository" "extras;android;m2repository" "extras;google;usb_driver"`
* $ `C:\Android\SDK\bin\sdkmanager.bat --sdk_root=C:\Android\SDK --update`
* Qt Creator -> Tools -> Options -> Devices -> Android
    * JDK -> C:\zulu
    * Android SDK -> C:\Android\SDK
    * Android NDK -> C:\Android\NDK

Install from archived (not recommend)
=====
* [archive]("https://download.qt.io/archive/online_installers/")

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

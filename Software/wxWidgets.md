Warrning, wxWidgets is way bloated than I thought. So there is no way I'll use it again.

It is also way much harder to use compare to Qt.

The following tutorial is a failure, I can not compile it successfully.











wxWidgets on Windows
=====
* Download and extract the source to "C:\wxWidgets"
* Go to "https://sourceforge.net/projects/mingw-w64"
* Go to "mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/VERSION/threads-posix/seh/"
* Download MinGW-w64, for compiling wxWidgets only, because I can't build it with cygwin-mingw
* Open powershell.exe
* $ $env:Path += ";C:\mingw64\bin"
* $ cd "C:\wxWidgets\build\msw"
* $ gvim "C:\wxWidgets\include\wx\platform.h"
* Replace include "wx/setup.h" with include "wx/msw/setup.h" # Don't replace it if failed!
```sh
mingw32-make -f makefile.gcc clean
mingw32-make -f makefile.gcc -j 2 CC=x86_64-w64-mingw32-gcc.exe CXX=x86_64-w64-mingw32-g++.exe BUILD=release SHARED=0 MONOLITHIC=0 UNICODE=1
mingw32-make -f makefile.gcc -j 2 CC=x86_64-w64-mingw32-gcc.exe CXX=x86_64-w64-mingw32-g++.exe BUILD=debug SHARED=0 MONOLITHIC=0 UNICODE=1
```

Code::Blocks on Windows with Cygwin
=====
* Download Code::Blocks without mingw
* Setting -> Compiler -> Global compiler settings -> Toolchain executables -> "C:\cygwin64"
* Setting -> Compiler -> Global compiler settings -> Toolchain executables -> Program Files
```conf
c compiler                  = x86_64-w64-mingw32-gcc.exe
c++ compiler                = x86_64-w64-mingw32-g++.exe
Linker for dynamic libs     = x86_64-w64-mingw32-g++.exe
Linker for static libs      = x86_64-w64-mingw32-ar.exe
Resource compiler           = x86_64-w64-mingw32-windres.exe
Make program                = make.exe
```
* Setting -> Compiler -> Global compiler settings -> Linker settings -> Other linker options
```conf
-static-libgcc -static-libstdc++ -static
```
* File -> New wxWidgets project -> WxSmith + Frame based -> "C:\wxWidgets"
    * Check "Use wxWidgets dll"
    * Check "wxWidgets is built as a monolithic libray"
    * Check "Enable unicode"
    * Check "Create and use precompiled header (PCH)"
    * Check "Configure Advanced Options"
* Check "GUI Mode Application"
* Setting -> Compiler -> Global compiler settings -> Linker settings -> Add -> "C:\wxWidgets\lib\gcc\_lib\libwxmsw30u.a"
* Setting -> Compiler -> Global compiler settings -> Search directories -> Compiler -> Add -> "C:\wxWidgets\lib\gcc\_lib\mswu"
* Setting -> Compiler -> Global compiler settings -> Search directories -> Linker -> Add -> "C:\wxWidgets\lib\gcc\_lib\mswu"
* Setting -> Compiler -> Global compiler settings -> Search directories -> Resource Compiler -> Add -> "C:\wxWidgets\lib\gcc\_lib\mswu"

Cmake with Code::Blocks
=====
* Code::Blocks doesn't support cmake directly
* $ cd build/
* $ cmake .. -G"CodeBlocks - MinGW Makefiles" # Windows
* $ cmake .. -G"CodeBlocks - Unix Makefiles" # Unix-like

Project Metadata
=====
```cmake
cmake_minimum_required(VERSION 3.2)
set(CMAKE_OSX_DEPLOYMENT_TARGET 10.6 CACHE STRING "Minimum OS X deployment version")
project(ProjectName LANGUAGES C)
set(PROJECT_VERSION_MAJOR "0")
set(PROJECT_VERSION_MINOR "16")
set(PROJECT_VERSION_PATCH "1")
set(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
```

OS detection
=====
```cmake
if(CYGWIN)
    # Cygwin thinks it's actually Linux.
    set(WIN32 TRUE)
    set(UNIX FALSE)
endif()

if(WIN32)
    set(WINDOWS TRUE)
elseif(APPLE)
    if(CMAKE_SYSTEM_NAME MATCHES ".*MacOS.*")
        set(MACOSX TRUE)
    endif()
elseif(UNIX)
    if(CMAKE_SYSTEM_NAME MATCHES ".*Linux")
        set(LINUX TRUE)
    elseif(CMAKE_SYSTEM_NAME MATCHES "kOpenBSD.*|OpenBSD.*")
        set(OPENBSD TRUE)
    elseif(CMAKE_SYSTEM_NAME MATCHES "kNetBSD.*|NetBSD.*")
        set(NETBSD TRUE)
    elseif(CMAKE_SYSTEM_NAME MATCHES "kFreeBSD.*|FreeBSD")
        set(FREEBSD TRUE)
    endif()
endif()
```

Architecture detection
=====
```cmake
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(ARCH_64 TRUE)
else()
  set(ARCH_64 FALSE)
endif()
```

Source another cmake file
=====
```cmake
if(WIN32)
    include(cmake/toolchain-win.cmake)
elseif(FREEBSD)
    include(cmake/toolchain-freebsd.cmake)
elseif(OPENBSD OR NETBSD)
    include(cmake/toolchain-openbsd.cmake)
elseif(APPLE)
    include(cmake/macOS.cmake)
endif()
```

Build flags (See CMakeLists.txt at github.com/uTox/uTox)
=====
```sh
SET(GCC_COVERAGE_COMPILE_FLAGS "--fprofile-arcs --ftest-coverage")
SET(GCC_COVERAGE_LINK_FLAGS    "-lgcov")
include_directories(${YOUR_DIRECTORY})

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}")
SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")

set(HEADER_FILES ${YOUR_DIRECTORY}/file1.h ${YOUR_DIRECTORY}/file2.h)
add_library(mylib libsrc.cpp ${HEADER_FILES})
add_executable(myexec execfile.cpp ${HEADER_FILES})
```


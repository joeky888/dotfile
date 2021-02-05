Code Design
=====
* Use functional programming
* Use a design pattern
* Use Enum and Switch-Case instead of If-Else
* Use Ternary Operator `? :` instead a single If-Else
* Optimization
    * Compute elapsed time
    * Use Map-Reduce (or other ways) if For-loop is slow
    * Use Bitwise operations
        * `&`   bitwise AND
        * `|`   bitwise inclusive OR
        * `^`   bitwise XOR (eXclusive OR)
        * `<<`  left shift
        * `>>`  right shift
        * `~`   bitwise NOT

RX
=====
* Use case
    1. User keeps input, like keydown or mouse move
    2. Big file slice
    3. Socket/WebSocket

Javascript
=====
* d3.js
* pixi.js - Fast WebGL d3.js replacement
* Zepto.js - Lightweight jquery-like lib
* vue.js
* clipboard.js - Copy to clipboard
* WebAssembly
* Microlight.js - Global code highting
* tiny-date-picker - Calendar date time picker
* micromodal.js - Tiny, dependency-free pop-up dialog
* laxxx.js - 3KB alternative to anime.js Animation lib
* Day.js - 2KB alternative to Moment.js parsing date time
* Webp-hero - webp format polyfill
* fetch
    * github.com/github/fetch - window.fetch JavaScript polyfill (Frontend)
    * github.com/bitinn/node-fetch - window.fetch for Node.js (Backend)
* React/React Native
    * A real world example app
        * https://github.com/gothinkster/react-redux-realworld-example-app
    * react-spring - Animation lib
    * react-native-router-flux - react-navigation based routing and navigation for react native
    * react-native-swiper - UI swiper component
    * preact - 3KB React alternative with the same modern API

CSS
=====
* postcss-cssnext - Compile modern CSS to old CSS
* pure-css - 4.5KB css framework (ie8+) based on normalize.css
* microtip.css - Lightweight tooptip lib

Browser
=====
* VS code: Editor
* WebExtension API

C and C++
=====
* Qt Creator
* Cmake
* Hardware checking
    * `https://github.com/google/cpu_features`
* Console interface
    * PDCurses
    * Ncurses
    * Termbox
* Porgress bar
    * `https://github.com/doches/progressbar`
* Math
    * Boost
* Single file libs
    * `https://github.com/RandyGaul/tinyheaders`
    * `https://github.com/nothings/single_file_libs`
* Web
    * Crow - Micro web framework for C++ (BSD license)

Python
=====
* PyCharm: IDE (Open source and free for both Personal and Commercial use)
* colorama: Simple cross-platform colored terminal text
    * `https://github.com/tartley/colorama`
* urwid: Console interface
    * Curses - standard python built-in lib
    * urwid
    * picotui - Minimal pure python lib without using ncurses, MicroPython supported
* japronto - Asynchronous HTTP server for py >= 3.5, but written in C

Go
=====
* Gin and Gorm
    * https://github.com/gothinkster/golang-gin-realworld-example-app
* fasthttp/fasthttprouter - Super fast for http(s) client and server
* iris - Fatest web framework
* algernon - Small self-contained pure-Go web server with Lua, Markdown, HTTP/2, QUIC, Redis and PostgreSQL support
* json
    * If code reflection is painful, just unmarsharl to string map
```go
var inInterface map[string]interface{}
json.Unmarshal(jsonStr, &inInterface)
```
    * https://github.com/valyala/fastjson - Get and Set json value without code reflection
    * github.com/buger/jsonparser - Get and Set json value without code reflection
* pp - Colored pretty printer for Go sturct

Java
=====
* Eclipse: IDE
* IntelliJ IDEA: IDE
* Android Studio: IDE
* Web server
    * Playframework - Full-featured
    * dropwizard - small and very fast

Data
=====
* TOML
* YAML
* Json

Comment
=====
* Important comments should be surrounding by the comment characters
```vim
""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
```
```c
/////////////////////
//    Documents    //
/////////////////////
```

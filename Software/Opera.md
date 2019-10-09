Setting
=====
* chrome://flags/#enable-parallel-downloading -> Enable
* chrome://flags/#enable-md-extensions -> Enable (Material design)
* chrome://flags/#save-page-as-mhtml -> Enable
* chrome://settings -> Search "VPN" -> Enable
* chrome://settings -> Search "Opera Turbo" -> Enable
* chrome://Plugins -> Search "flash" -> Enable
<!-- * chrome://flags/#smooth-scrolling -> Enable -->
<!-- * chrome://flags/#personal-news-notifications -> Enable -->
<!-- * chrome://flags/#enable-quic -> Enable -->
<!-- * chrome://flags/#toolkit-bookmarks -> Enable -->
<!-- * chrome://flags/#enable-suggestions-with-substring-match -> Enable -->
<!-- * chrome://flags/#enable-simple-cache-backend -> Enable -->
<!-- * chrome://flags/#enable-client-lo-fi -> Enable -->
<!-- * chrome://flags/#enable-module-scripts-import-meta-url -> Enable -->
<!-- * chrome://flags/#enable-javascript-harmony -> Enable -->
<!-- * chrome://flags/#enable-asm-webassembly -> Enable -->
<!-- * chrome://flags/#enable-webassembly -> Enable -->
<!-- * chrome://flags/#enable-webassembly-streaming -> Enable -->
<!-- * chrome://flags/#enable-future-v8-vm-features -> Enable -->
<!-- * chrome://flags/#enable-experimental-web-platform-features -> Enable -->
<!-- * chrome://flags/#overlay-scrollbars -> Enable (Automatically hidding scrollbar) -->
<!-- * chrome://flags/#disable-background-video-track -> Enable -->
<!-- * chrome://flags/#enable-new-print-preview -> Enable -->
<!-- * chrome://flags/#enable-async-image-decoding -> Enable -->
* Chrome Dev tool -> ... -> Setting -> Theme -> Dark

Extension
=====
* Install Chrome Extension
* Adblock Plus
* Search by Image (by Google)
* Stylish / Stylus
* Full Page Screen Capture
* SimpleUndoClose
* Tampermonkey (Opera addon)
    * https://github.com/syhyz1990/baiduyun
* RightToCopy
* Enable Copy by keakon.net
* Set Character Encoding
* HackBar
* User-Agent Switcher for Chrome by Google
* HTTPS Everywhere
* Disconnect
* Remove Google Redirection
* Get CRX
* Enhanced Github
* No Coin
* LanguageTool
* JSON Viewer
* XV XML Viewer
* Video Speed Controller
* Reddit Enhancement Suite
* Hacker News Enhancement Suite
* Quora Unblocker
* Privacy Badger
* BaiduExporter
* Secure Shell Extension
* Selenium IDE / Katalon Recorder
* FoxyProxy (Remember to enable Proxy Mode "Use proxied based on their pre-defined pattern and proxies"; Uncheck "SOCKS proxy？")
* Line (ophjlpahpchlmihnnnihgmmeilfjmjjc)
* 飛比價格購物幫手
* LXRSS
    * New Tab Start Page (by www.sermak.ca) and set to "chrome-extension://egamohfjegpahoddmbhmmhacpbepnkcb/tab.html"
* Touch VPN (For pan.baidu.com, EDIT: Use Opera VPN instead)

RSS list
=====
* 中文
https://feeds.feedburner.com/techbang
https://www.gamebase.com.tw/news/rss/0
http://news.everydayhealth.com.tw/feed
https://feeds.feedburner.com/engadget/cstb
https://technews.tw/tn-rss/
https://feeds.feedburner.com/pcadv
https://feeds.feedburner.com/cool3c-show
https://www.ithome.com.tw/rss
https://www.kocpc.com.tw/feed
http://techcrunch.cn/feed
http://www.azofreeware.com/feeds/posts/default
http://www.oschina.net/news/rss
https://linux.cn/rss.xml
https://studygolang.com/feed.xml
http://feeds.bbci.co.uk/zhongwen/trad/rss.xml
https://www.ithome.com/rss
https://www.freebuf.com/feed
https://www.infoq.cn/feed

* English
https://feeds.feedburner.com/d0od
https://www.phoronix.com/rss.php
https://feeds.feedburner.com/engadget
https://feeds.feedburner.com/TechCrunch
https://opensource.com/feed
https://feeds.feedburner.com/linuxtoday/linux
http://feeds.bbci.co.uk/news/technology/rss.xml
https://www.pcgamer.com/rss

* Github
```
https://mshibanami.github.io/GitHubTrendingRSS/daily/all.xml
https://mshibanami.github.io/GitHubTrendingRSS/weekly/all.xml
https://mshibanami.github.io/GitHubTrendingRSS/weekly/go.xml
https://mshibanami.github.io/GitHubTrendingRSS/weekly/rust.xml
```


Bookmark script
=====
* Dark
```javascript
javascript:(function(){ var h=document.getElementsByTagName('head')[0],s=document.createElement('style');s.setAttribute('type','text/css'); s.appendChild(document.createTextNode('html{-webkit-filter:invert(100%) hue-rotate(180deg) contrast(70%) !important; background: #fff;} .line-content {background-color: #fefefe;}'));h.appendChild(s); })()
```
* Mono
```javascript
javascript:(function(){ var h=document.getElementsByTagName('head')[0],s=document.createElement('style');s.setAttribute('type','text/css'); s.appendChild(document.createTextNode('@font-face{font-family:ASCII;src:local("Ubuntu Mono"),local("Consolas");unicode-range:U+00-7F,U+FF01-FF5E}@font-face{font-family:CJK;src:local("Droid Sans Fallback"),local("DroidMono"),local("Wenquanyi Micro Hei"),local("WenQuanYi Zen Hei"),local("Sarasa Mono TC"),local("Microsoft JhengHei"),local("Microsoft YaHei");unicode-range:U+2E80-FAFF}*,* *,[class],[id],[name]{font-family:ASCII,CJK,sans-serif!important;font-weight:400!important}'));h.appendChild(s); })()
```

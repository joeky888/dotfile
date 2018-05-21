Setting
=====
* chrome://flags/#scroll-on-active-tab-on-click -> Disable
* chrome://flags/#smooth-scrolling -> Enable
* chrome://flags/#personal-news-notifications -> Enable
* chrome://flags/#save-page-as-mhtml -> Enable
* chrome://flags/#enable-quic -> Enable
* chrome://flags/#toolkit-bookmarks -> Enable
* chrome://flags/#enable-suggestions-with-substring-match -> Enable
* chrome://flags/#enable-simple-cache-backend -> Enable
* chrome://flags/#enable-client-lo-fi -> Enable
* chrome://flags/#enable-module-scripts-import-meta-url -> Enable
* chrome://flags/#enable-javascript-harmony -> Enable
* chrome://flags/#enable-asm-webassembly -> Enable
* chrome://flags/#enable-webassembly -> Enable
* chrome://flags/#enable-webassembly-streaming -> Enable
* chrome://flags/#enable-future-v8-vm-features -> Enable
* chrome://flags/#enable-experimental-web-platform-features -> Enable
* chrome://flags/#overlay-scrollbars -> Enable (Automatically hidding scrollbar)
* chrome://flags/#enable-md-extensions -> Enable (Material design)
* chrome://flags/#disable-background-video-track -> Enable
* chrome://flags/#enable-new-print-preview -> Enable
* chrome://flags/#enable-async-image-decoding -> Enable
* chrome://flags/#enable-parallel-downloading -> Enable
* chrome://Plugins -> Search "flash" -> Enable
* chrome://settings -> Search "VPN" -> Enable
* chrome://settings -> Search "Opera Turbo" -> Enable

Extension
=====
* Install Chrome Extension
* Adblock Plus
* Search by Image (by Google)
* Stylish / Stylus
* Full Page Screen Capture
* TJDict
* SimpleUndoClose
* Tampermonkey
* RightToCopy
* Set Character Encoding
* User-Agent Switcher for Chrome by Google
* HTTPS Everywhere
* Disconnect
* Remove Google Redirection
* GitHub Plus
* No Coin
* Video Speed Controller
* Reddit Enhancement Suite
* Hacker News Enhancement Suite
* Privacy Badger
* BaiduExporter
* Secure Shell Extension
* ZScaler Bypass (for ASUS ZScaler)
* FoxyProxy (Remember to enable Proxy Mode "Use proxied based on their pre-defined pattern and proxies"; Uncheck "SOCKS proxy？")
* Turbo Download Manager (Opera Extension)
* Line (ophjlpahpchlmihnnnihgmmeilfjmjjc)
* 飛比價格購物幫手
* Monokai for Chrome:
    * chrome://flags -> Developer Tools experiments (or chrome://flags/#enable-devtools-experiments) -> enable -> Relaunch Now
    * Open DevTools -> settings -> experiments -> Allow custom UI themes -> Check
* LXRSS
    * Custom New Tab Page (Opera Extension) and set to "chrome-extension://egamohfjegpahoddmbhmmhacpbepnkcb/tab.html"
* Deprecated
    * Free Proxy to Unblock any sites (For pan.baidu.com, EDIT: Use Opera VPN instead)

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
https://ithelp.ithome.com.tw/rss/articles/tech
https://www.kocpc.com.tw/feed

* English
https://feeds.feedburner.com/d0od
https://www.phoronix.com/rss.php
https://feeds.feedburner.com/engadget
https://feeds2.feedburner.com/webupd8
https://feeds.feedburner.com/TechCrunch
https://opensource.com/feed
https://feeds.feedburner.com/linuxtoday/linux
https://blog.qt.io/feed
https://godotengine.org/rss.xml

* Github
```
http://github-trends.ryotarai.info/rss/github_trends_all_daily.rss
http://github-trends.ryotarai.info/rss/github_trends_all_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_c?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_c%23?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_c++?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_cmake?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_css?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_diff?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_dockerfile?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_gdscript?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_go?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_java?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_javascript?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_kotlin?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_powershell?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_python?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_qml?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_shell?since=daily_weekly.rss
http://github-trends.ryotarai.info/rss/github_trends_typescript?since=daily_weekly.rss
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

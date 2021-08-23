Setting
=====
* chrome://flags/#enable-parallel-downloading -> Enable
* chrome://flags/#enable-quic -> Enable
* Hardware acceleration
  * Currently Chrome on Linux works but opera on Linux doesn't work
    * chrome://flags/#enable-accelerated-video-decode -> Enable (This one is deprecated, use --enable-features=VaapiVideoDecoder instead)
  * chrome://flags/#ignore-gpu-blocklist -> Enable (Or try to disable it if doesn't work)
  * chrome://gpu -> Check hardware decode is enabled
  * Also install h264ify chrome extension
  * Play an youtube hd video and open a new tab enter dev tool using Ctrl-Shift-i
    * 3 dots vertical dots menu -> More tools -> Media
    * video coder name should be VDAVideoDecoder or MojoVideoDecoder or GpuVideoDecoder instead of FFmpegVideoDecoder or VpxVideoDecoder
* chrome://settings -> Search "VPN" -> Enable
* chrome://settings -> Search "Opera Turbo" -> Enable
* chrome://settings -> Search "Font"
  * Standard font -> Noto Sans CJK TC
  * Serif font -> Noto Sans CJK TC
  * Sans-serif font -> Noto Sans CJK TC
* chrome://Plugins -> Search "flash" -> Enable
* Chrome Dev tool -> ... -> Setting -> Theme -> Dark

Extension
=====
* Install Chrome Extension
* Adblock Plus
* Dark Reader
* Search by Image (by Google)
* Stylish / Stylus
* Full Page Screen Capture
* SimpleUndoClose
* Tampermonkey (Opera addon)
  * https://github.com/syhyz1990/baiduyun (Secret: 94108)
* RightToCopy
* Enable Copy by keakon.net
* Set Character Encoding
* Marinara - Pomodoro® Assistant
<!-- * HackBar -->
* User-Agent Switcher for Chrome by Google
<!-- * HTTPS Everywhere -->
<!-- * Disconnect -->
* Remove Google Redirection
* Wappalyzer
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
* Touch VPN (For pan.baidu.com)

RSS list
=====
* 中文
https://feeds.feedburner.com/techbang
https://news.gamebase.com.tw/rss.xml
http://news.everydayhealth.com.tw/feed
https://feeds.feedburner.com/engadget/cstb
https://technews.tw/tn-rss/
https://feeds.feedburner.com/pcadv
https://feeds.feedburner.com/cool3c-show
https://www.ithome.com.tw/rss
https://www.kocpc.com.tw/feed
http://www.azofreeware.com/feeds/posts/default
http://www.oschina.net/news/rss
https://linux.cn/rss.xml
http://feeds.bbci.co.uk/zhongwen/trad/rss.xml
https://www.ithome.com/rss
https://www.freebuf.com/feed
https://www.infoq.cn/feed
https://rust.cc/rss
https://rsshub.app/toutiao/today

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
https://mshibanami.github.io/GitHubTrendingRSS/weekly/go.xml
https://mshibanami.github.io/GitHubTrendingRSS/weekly/rust.xml
```

Tor
=====
* Install Brave with built-in tor
  * Go to https://check.torproject.org/ check if it works
* Links
  * Collection of onion links
    * The hidden wiki: http://zqktlwiuavvvqqt4ybvgvi7tyo4hjl5xgfuvpdf6otjiycgwqbym2qad.onion/wiki/index.php
    * Torlinks: http://torlinksge6enmcyyuxjpjkoouw4oorgdgeo7ftnq3zodj7g2zxi3kyd.onion/

NSFW
=====
* 4chan gif board rekt threads
* https://sora.komica.org/00

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

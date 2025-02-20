Setting
=====
* chrome://flags/#enable-parallel-downloading -> Enable
* chrome://flags/#enable-quic -> Enable
* chrome://flags/#enable-vulkan -> Enable
* chrome://flags/#enable-experimental-webassembly-features -> Enable
* Hardware acceleration
  * chrome://settings -> Search "Hardware acceleration" -> Enable
  * Install extension "Not yet, AV1"
* chrome://settings -> Search "VPN" -> Enable
* chrome://settings -> Search "Font"
  * Standard font -> Noto Sans CJK TC
  * Serif font -> Noto Sans CJK TC
  * Sans-serif font -> Noto Sans CJK TC
  * Fixed-width font -> Noto Sans Mono CJK TC
* Chrome Dev tool -> ... -> Setting -> Theme -> Dark
* Settings -> Enable DOH (DNS over https) and Add Custom DNS -> Enter "https://cloudflare-dns.com/dns-query" (Only this way it will respect /etc/hosts)
* Settings -> Enable Battery saver

Opera GX Only
=====
* Enable "Early bird" in the settings - opera://settings/early_bird

Extension
=====
* Adguard extension
* uBlock Origin Development Build (cgbcahbpdhpcegmbfconppldiemgcoii) (MV2 will be disabled in mid 2024)
* uBlock Origin Lite (ddkjiahejlhfcafbddmgiahcphecmpfh) (MV3)
* Dark Reader
* Search by Image (by Google)
* Not yet, AV1
* Stylish / Stylus
* Full Page Screen Capture
* SimpleUndoClose
* RSS Feed Reader (feeder.co)
* SponsorBlock
  * Unpaid/Self Promotion -> Auto Skip
  * Interaction Reminder (Subscribe) -> Auto Skip
  * Intermission/Intro Animation -> Auto Skip
  * Preview/Recap/Hook -> Show in seekbar
* BilibiliSponsorBlock
  * 无偿/自我推广 -> 自動跳過
  * 三连/订阅提醒 -> 自動跳過
  * 过场/开场动画 -> 自動跳過
* Tampermonkey (Closed source)
  * https://github.com/syhyz1990/baiduyun (Secret: 94108)
* Violentmonkey (Open source)
  * https://github.com/the1812/Bilibili-Evolved (Download 720P bilibili videos)
    * Click toolbox on the left -> Click 組件 on the bottom left -> 在線 -> Install 合集包 (下載器、常用功能包)
* PTT Imgur Fix (aka Ptt Media Preview)
* RightToCopy
* Elmo Chat - Your AI Web Copilot
* Enable Copy by keakon.net
* Set Character Encoding
* User-Agent Switcher for Chrome by Google
* Remove Google Redirection
* Load Lazyload Images
* Wappalyzer
* YouTube LiveChat Flusher (Danmaku LiveChat)
* bypass-paywalls-chrome
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
* Wayback Machine
* Ruffle-rs (Flash player emulator)
* Line (ophjlpahpchlmihnnnihgmmeilfjmjjc)
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
https://feeds.feedburner.com/cool3c-show
https://www.ithome.com.tw/rss
https://www.kocpc.com.tw/feed
http://www.oschina.net/news/rss
https://www.ithome.com/rss
https://www.freebuf.com/feed
https://www.infoq.cn/feed
http://sputniknews.cn/export/rss2/archive/index.xml

* English
https://www.phoronix.com/rss.php
https://feeds.feedburner.com/engadget
https://feeds.feedburner.com/TechCrunch
https://opensource.com/feed
https://feeds.feedburner.com/linuxtoday/linux
https://thenewstack.io/blog/feed/
http://feeds.bbci.co.uk/news/technology/rss.xml
https://www.pcgamer.com/rss
https://sputniknews.com/export/rss2/archive/index.xml

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

Extension upgrade requires additional permissions
=====
* Enable all disabled extension
* Hit "Update" button

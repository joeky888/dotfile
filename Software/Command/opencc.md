Install opencc on cygwin
=====
* Install cmake doxygen
* $ git clone --depth=1 https://github.com/BYVoid/OpenCC.git
* $ make
* $ make install
* Copy "build/rel/src/cygopencc-2.dll" to "/bin" or "C:\Windows\System32"

List of help
=====
* $ opencc -h

簡 to 繁
=====
* $ opencc -i input.txt -c s2tw.json -o output.txt

繁 to 簡
=====
* $ opencc -i input.txt -c tw2s.json -o output.txt

Default configre files
====
* s2t.json Simplified Chinese to Traditional Chinese 簡體到繁體
* t2s.json Traditional Chinese to Simplified Chinese 繁體到簡體
* s2tw.json Simplified Chinese to Traditional Chinese (Taiwan Standard) 簡體到臺灣正體
* tw2s.json Traditional Chinese (Taiwan Standard) to Simplified Chinese 臺灣正體到簡體
* s2hk.json Simplified Chinese to Traditional Chinese (Hong Kong Standard) 簡體到香港繁體（香港小學學習字詞表標準）
* hk2s.json Traditional Chinese (Hong Kong Standard) to Simplified Chinese 香港繁體（香港小學學習字詞表標準）到簡體
* s2twp.json Simplified Chinese to Traditional Chinese (Taiwan Standard) with Taiwanese idiom 簡體到繁體（臺灣正體標準）並轉換爲臺灣常用詞彙
* tw2sp.json Traditional Chinese (Taiwan Standard) to Simplified Chinese with Mainland Chinese idiom 繁體（臺灣正體標準）到簡體並轉換爲中國大陸常用詞彙
* t2tw.json Traditional Chinese (OpenCC Standard) to Taiwan Standard 繁體（OpenCC 標準）到臺灣正體
* t2hk.json Traditional Chinese (OpenCC Standard) to Hong Kong Standard 繁體（OpenCC 標準）到香港繁體（香港小學學習字詞表標準）

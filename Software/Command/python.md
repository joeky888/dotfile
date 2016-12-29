Json prettify
=====
* $ echo '{"foo": "lorem", "bar": "ipsum"}' | python3 -m json.tool
* Support unicode
    * Find python json module, ex: /usr/lib/python3/json
    * Edit tool.py, add `ensure_ascii = False` option to `json.dump` function
    * $ echo '{"中文": "中文", "測試": "測試"}' | python3 -m json.tool

Unicode Json prettify
=====
* $ echo '{"foo": "lorem", "bar": "ipsum"}' | python3 -m json.tool
* Support unicode
    * Find python json module, ex: /usr/lib/python3/json
    * Edit tool.py, add `ensure_ascii = False` option to `json.dump` function
    * $ echo '{"中文": "中文", "測試": "測試"}' | python3 -m json.tool

Create python virtual env
=====
* Create python2.6 named py26
* $ conda2 create -n py26 python=2.6
* Create python2.6 named py26 with anaconda
* $ conda2 create -n py26 python=2.6 anaconda
* The path will be like this ~/miniconda2/envs/py26/bin

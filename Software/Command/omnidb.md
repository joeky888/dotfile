Install
=====
* $ git clone --depth 1 https://github.com/OmniDB/OmniDB && cd OmniDB
* $ pip3 install -r requirements.txt
* $ python OmniDB/omnidb-server.py # Just python, don't use python2 or python3
* Open 127.0.0.1:8000, Login as admin/admin (opera doesn't support right click menus, use chrome)

<!-- Set utf8 -->
<!-- ===== -->
<!-- * $ cd OmniDB && grep -RiIn "pymysql.connect" -->
<!-- * Append `charset='utf8', use_unicode=True` to the function "pymysql.connect" -->

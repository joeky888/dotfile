uv and pyproject.toml
=====
```sh
pip install uv
uv init proj && cd proj
uv add opencv-python # import cv2
uv run python hello.py
```

poetry and pyproject.toml
=====
```sh
pip install poetry
poetry new proj && cd proj
poetry add opencv-python # import cv2
poetry run python -i # test if it is ok
poetry run proj hw01/__init__.py
```


Install jupyter lab (next-gen jupyter notebook)
=====
```sh
pip install jupyterlab
jupyter lab --NotebookApp.token='' # Don't require login
```

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

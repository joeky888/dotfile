uv and pyproject.toml
=====
```sh
pip install uv
uv init proj && cd proj
uv add opencv-python # import cv2
uv run python hello.py
```
* Add ruff lint to pyproject.toml
```toml
[tool.ruff.lint]
select = [
    "ALL", # include all the rules, including new ones
]
ignore = [
    #### modules
    "ANN", # flake8-annotations
    "COM", # flake8-commas
    "C90", # mccabe complexity
    "DJ",  # django
    "EXE", # flake8-executable
    "T10", # debugger
    "TID", # flake8-tidy-imports

    #### specific rules
    "D100",   # ignore missing docs
    "D101",
    "D102",
    "D103",
    "D104",
    "D105",
    "D106",
    "D107",
    "D200",
    "D205",
    "D212",
    "D400",
    "D401",
    "D415",
    "E402",   # false positives for local imports
    "E501",   # line too long
    "TRY003", # external messages in exceptions are too verbose
    "TD002",
    "TD003",
    "FIX002", # too verbose descriptions of todos
]

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

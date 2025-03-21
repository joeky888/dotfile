VsCodium extension
=====
* find the product.json
* $ sudo fd product.json /
* Edit
```js
// Replace
 "extensionsGallery": {
    "serviceUrl": "https://open-vsx.org/vscode/gallery",
    "itemUrl": "https://open-vsx.org/vscode/item"
},

// With
"extensionsGallery": {
    "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
    "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
    "itemUrl": "https://marketplace.visualstudio.com/items"
},
```

Extension
=====
* be5invis.vscode-custom-css
  * Run "> Enable Custom CSS and JS"
* vscode-icons-team.vscode-icons
* Rust
  * vadimcn.vscode-lldb
  * rust-lang.rust-analyzer and switch to pre-realese version
* golang.Go
* eslint
* Markdown All in One (opt+shift+f to format tables)
* Gitlens
* Vscode-proto3
* Shellcheck
* Versionlens - Check update for package.json
* ms-azuretools.vscode-docker
* be5invis.toml
* hediet.vscode-drawio
* fill-labs.dependi
* ms-kubernetes-tools.vscode-kubernetes-tools
* bradlc.vscode-tailwindcss
* charliermarsh.ruff (python linter)

Diff 2 file
=====
* Open a.txt
* Hit F1 -> Compare active file with -> Select b.txt
* Note that only b.txt can be modified

Typscript auto completion
=====
* Install DefinitelyTyped like this
* $ npm install --save-dev @types/d3
* Add the path to the first line of the .js file
```javascript
/// <reference path="/home/joeky/project/node_modules/@types/d3/index.d.ts" />
```

Golang auto completion
=====
* Install ms-vscode.go extension
* Install all recommend go packages from vscode-go
* Enable auto-save

Macos use native tabs by default
=====
* `"window.nativeTabs": true`
* System setting > Desktop and Dock > Prefer tabs when opening documents > Always
* $ code .

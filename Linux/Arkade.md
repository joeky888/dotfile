Install or Upgrade (Don't use sudo)
=====
* This will perform install if not found or upgrade if found
```sh
curl -sLS https://get.arkade.dev | sh
```

Uninstall all
=====
```sh
rm -rf ~/.arkade
```

CLI tools to install or upgrade
=====
* arkade get will perform install if not found or upgrade if found
```sh
arkade get k9s
arkade get yq
arkade get linkerd2
```

Install nix
=====
```sh
app-fast -S nix
sudo systemctl enable --now nix-daemon.service
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
sudo usermod -aG nix-users $(whoami) # Optional
sudo chown -R $USER:$USER /nix
```

Install vscode
=====
```sh
NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixpkgs.vscode
```


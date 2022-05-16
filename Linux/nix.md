Install nix
=====
```sh
curl --proto '=https' --tlsv1.2 -sSfL https://nixos.org/nix/install | bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
#sudo usermod -aG nix-users $(whoami) # Optional
#sudo chown -R $USER:$USER /nix # No need anymore
```

Install Packages
=====
```sh
nix-env -iA nixpkgs.awscli2 nixpkgs.aws-iam-authenticator \
  nixpkgs.linkerd nixpkgs.k9s \
  nixpkgs.terraform nixpkgs.tflint \
  nixpkgs.protoc-gen-go
```

Uninstall Packages
=====
```sh
nix-env --uninstall vscode
nix-env --delete-generations old
nix-store --gc --print-dead
```

Upgrade all packages
=====
```sh
nix-channel --update && nix-env -u
```

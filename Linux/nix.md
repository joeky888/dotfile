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
  nixpkgs.protobuf nixpkgs.protoc-gen-go \
  nixpkgs.shellcheck nixpkgs.jq \
  nixpkgs.bun nixpkgs._7zz \
  nixpkgs.oha
```

Uninstall Packages
=====
```sh
nix-env --uninstall vscode
```

Upgrade all packages
=====
```sh
nix-channel --update && nix-env -u && nix-env --delete-generations old && nix-collect-garbage -d
```

Install ClamAV
=====
```sh
nix-env -iA nixpkgs.clamav
sudo mkdir -p /etc/clamav && sudoedit /etc/clamav/freshclam.conf
########### Paste this
DatabaseDirectory /var/lib/clamav
UpdateLogFile /var/log/freshclam.log
LogTime yes
DatabaseOwner root
DatabaseMirror database.clamav.net
###########

sudo freshclam --config-file /etc/clamav/freshclam.conf
clamscan --database /var/lib/clamav --infected -r /home # print infected only
```

Install mpv
=====
* See `https://nixos.wiki/wiki/Nixpkgs_with_OpenGL_on_non-NixOS`
```sh
nix-env -iA nixpkgs.mpv-unwrapped
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault nixgl.nixGLIntel
nixGLIntel ~/.nix-profile/bin/mpv LINK
```

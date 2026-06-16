Install
=====
```sh
sudo apt update && sudo apt install build-essential procps curl file git -y

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# For bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# For Zsh
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# For fish
echo 'eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.config/fish/config.fish
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
```

Install pacakges
=====
```sh
brew install k9s aws-iam-authenticator awscli
```

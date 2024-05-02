# Syhol Dotfiles


## Setup Instructions

```sh
# Install brew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Load config
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot syhol

# Install packages
brew bundle --file ~/.config/brewfile/Brewfile

# Checkout config
chezmoi init --apply --verbose https://github.com/syhol/dotfiles.git
```

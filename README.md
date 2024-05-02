# Syhol Dotfiles


## Setup Instructions

```sh
# Install config and programs
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot syhol

# Checkout the dotfiles repo to keep it in sync
chezmoi init --apply --verbose https://github.com/syhol/dotfiles.git
```

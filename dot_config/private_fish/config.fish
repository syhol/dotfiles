/opt/homebrew/bin/brew shellenv | source
$HOME/.local/bin/mise activate fish --shims | source

source "$HOME/.config/shell/foundation.sh"
source "$HOME/.config/fish/load_plugins.fish"

if status is-interactive
    mise activate fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
end

source "$HOME/.config/shell/foundation.sh"
source "$HOME/.config/fish/load_plugins.fish"
/opt/homebrew/bin/brew shellenv | source
mise activate fish --shims | source

if status is-interactive
    mise activate fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
end

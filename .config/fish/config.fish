source "$HOME/.config/shell/foundation.sh"
source "$HOME/.config/fish/plugins.fish"

if status is-interactive
    mise activate fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
    test -n "$FISH_THEME"; and fish_config theme choose "$FISH_THEME"
end

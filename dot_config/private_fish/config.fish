source "$HOME/.config/shell/foundation.sh"
source "$HOME/.config/fish/load_plugins.fish"

if status is-interactive
    mise activate fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/simon/.lmstudio/bin
# End of LM Studio CLI section


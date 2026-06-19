source "$HOME/.config/shell/foundation.sh"
source "$HOME/.config/zsh/plugins.zsh"

eval "$(mise activate zsh)"
eval "$(fzf --zsh)"                # 2ms
eval "$(zoxide init zsh --cmd cd)" # 2ms
eval "$(starship init zsh)"

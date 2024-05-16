# Aliases
alias fzf-vim-selector="fzf \
  --height 50% --min-height 20 --reverse --info=inline \
  --margin=1,2,0,2 --padding=1,2 --border \
  --no-scrollbar --preview-window bottom,border-top \
  --preview 'bat --style=numbers --color=always --line-range :500 {}' \
"
alias vd="fd --type f --hidden --exclude .git | fzf-vim-selector | xargs nvim"
alias vr="nvim --headless -c 'echo v:oldfiles | q' 2>&1 | sed 's/'\''/\"/g' | jq '.[]' -r | fzf-vim-selector | xargs nvim"
alias vim="nvim"
alias ls="eza --icons --group-directories-first"
alias ll="eza -al --icons --group-directories-first"
alias tree="eza -T"
alias cat="bat"
alias diff="difft"
alias dig="dog"
alias watch="viddy"
alias grep="rg -uuu -g '!{**/node_modules/*,**/.git/*}'"
alias cz="chezmoi"
alias k="kubectl"
alias kg="kubectl get"
alias kd='kubectl describe'
alias krm='kubectl delete'
include () {
    [[ -f "$1" ]] && source "$1"
}


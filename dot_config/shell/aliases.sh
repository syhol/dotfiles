# This file is meant to compatible with multiple shells, including:
# bash, zsh and fish. For this reason, use this syntax:
#  alias aliasname="alias command"

alias fzf-vim-selector="fzf \
  --height 50% --min-height 20 --reverse --info=inline \
  --margin=1,2,0,2 --padding=1,2 --border \
  --no-scrollbar --preview-window bottom,border-top \
  --preview 'bat --style=numbers --color=always --line-range :500 {}' \
"
alias vd="fd --type f --hidden --exclude .git | fzf-vim-selector | xargs nvim"
alias vr="nvim --headless -c 'echo v:oldfiles | q' 2>&1 | sed 's/'\''/\"/g' | jq '.[]' -r | fzf-vim-selector | xargs nvim"
alias vim="nvim"
alias ls="eza -al --icons --group-directories-first"
alias tree="eza -T"
alias cat="bat"
alias diff="difft"
alias dig="dog"
alias 7z="7zz"
alias compress="7z a"
alias decompress="7z x"
alias watch="viddy"
alias grep="rg -uuu -g '!{**/node_modules/*,**/.git/*}'"
alias http="xh"
alias cz="chezmoi"
alias m="mise"
alias mr="mise run"
alias k="kubectl"
alias kg="kubectl get"
alias klo="kubectl logs"
alias kd='kubectl describe'
alias krm='kubectl delete'
alias capably='mise run'
alias c='mise run'

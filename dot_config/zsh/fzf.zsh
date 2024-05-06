
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

export _ZO_FZF_OPTS="${FZF_DEFAULT_OPTS} \
  --height 50% --min-height 20 --reverse --info=inline \
  --reverse --margin=1,2,0,2 --padding=1,2 --border \
  --no-scrollbar --preview-window bottom,border-top \
  --preview 'eza --color=always --group-directories-first {2..}' \
"

export FZF_CTRL_R_OPTS=" \
  --height 50% --min-height 20 --reverse --info=inline \
  --reverse --margin=1,2,0,2 --padding=1,2 --border \
  --no-scrollbar \
"


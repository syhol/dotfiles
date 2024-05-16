
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --prompt '∷ ' --pointer ▶ \
  --color=fg:#c0caf5,hl:#ff9e64 \
  --color=fg+:#c0caf5,bg+:-1,hl+:#ff9e64 \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a \
  --reverse --info=hidden \
  --no-scrollbar --preview-window right,border-left \
"

export _ZO_FZF_OPTS="${FZF_DEFAULT_OPTS} \
  --preview 'eza --color=always --icons always --group-directories-first --all --width 1 {2..}' \
"

export FZF_ALT_C_OPTS="${FZF_DEFAULT_OPTS} \
  --preview 'eza --color=always --icons always --group-directories-first --all --width 1 {} ' \
"

export FZF_CTRL_T_OPTS="${FZF_DEFAULT_OPTS} \
  --preview 'eza --color=always --icons always --group-directories-first --all --width 1 {} ' \
"

export FZF_CTRL_R_OPTS="${FZF_DEFAULT_OPTS} \
  --preview-window 1,bottom,wrap,border-top \
  --preview 'echo {2..} | bat --style=plain --paging=never --color=always --wrap=character -l bash' \
"

# FZF
export FZF_DEFAULT_OPTS=" \
  --prompt '∷ ' --pointer ▶ \
  --gutter ▎ \
  --color=gutter:#565656 \
  --color=fg:#c0caf5,hl:#ff9e64 \
  --color=fg+:#c0caf5,bg+:-1,hl+:#ff9e64 \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a \
  --reverse --info=hidden \
  --ansi \
  --no-scrollbar --preview-window right,border-left \
  --height=50% \
"
export FZF_DEFAULT_COMMAND='fd --type f --color=always --strip-cwd-prefix --hidden --follow'

# jethrokuan/fzf (fish)
export FZF_COMPLETE=2
export FZF_PREVIEW_FILE_CMD="bat --style=plain --paging=never --color=always --wrap=character"
export FZF_PREVIEW_DIR_CMD="eza --color=always --icons always --group-directories-first --all --width 1"
export FZF_FIND_FILE_COMMAND="fd --type f --color=always --hidden \$dir"
export FZF_OPEN_COMMAND="fd --type f --color=always --hidden \$dir"
export FZF_CD_COMMAND="fd --type d --color=always --hidden \$dir"
export FZF_CD_WITH_HIDDEN_COMMAND="fd --type d --color=always --hidden ~"
export FZF_FIND_FILE_OPTS="--preview '$FZF_PREVIEW_FILE_CMD {}'"
export FZF_CD_OPTS="--preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_CD_WITH_HIDDEN_OPTS="--preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_REVERSE_ISEARCH_OPTS="--preview 'echo {2..} | $FZF_PREVIEW_FILE_CMD -l bash' --preview-window 1,bottom,wrap,border-top"
export FZF_ENABLE_OPEN_PREVIEW=1
export FZF_DISABLE_KEYBINDINGS=0
export FZF_LEGACY_KEYBINDINGS=1
export FZF_TMUX_HEIGHT="40%"

# Core FZF key bindings
export FZF_ALT_C_OPTS="--preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_CTRL_T_OPTS="--preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {2..} | $FZF_PREVIEW_FILE_CMD -l bash' --preview-window 1,bottom,wrap,border-top"

# Yazi and Zoxide
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview '$FZF_PREVIEW_DIR_CMD {2..}'"
export YAZI_ZOXIDE_OPTS="--no-border --no-cycle --preview-window right,border-left --preview '$FZF_PREVIEW_DIR_CMD {2..}'"

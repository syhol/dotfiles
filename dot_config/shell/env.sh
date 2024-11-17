# This file is meant to compatible with multiple shells, including:
# bash, zsh and fish. For this reason, use this syntax:
#    export VARNAME=value

export EDITOR="nvim"
export DISABLE_OPENCOLLECTIVE=true
export CLICOLOR=1
export EXA_ICON_SPACING=2
export VIRTUAL_ENV_DISABLE_PROMPT=1
export BASH_SILENCE_DEPRECATION_WARNING=1

# FZF
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --prompt '∷ ' --pointer ▶ \
  --color=fg:#c0caf5,hl:#ff9e64 \
  --color=fg+:#c0caf5,bg+:-1,hl+:#ff9e64 \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a \
  --reverse --info=hidden \
  --no-scrollbar --preview-window right,border-left \
  --height=50% \
"

export FZF_COMPLETE=2
export FZF_PREVIEW_FILE_CMD="bat --style=plain --paging=never --color=always --wrap=character"
export FZF_PREVIEW_DIR_CMD="eza --color=always --icons always --group-directories-first --all --width 1"
export FZF_OPEN_COMMAND="fd --type f --hidden --exclude .git --exclude node_modules \$dir"
export FZF_ENABLE_OPEN_PREVIEW=1
export FZF_CD_COMMAND="fd --type d --hidden --exclude .git --exclude node_modules \$dir"
export FZF_CD_WITH_HIDDEN_COMMAND="fd --type d --hidden --exclude .git --exclude node_modules . ~"
export FZF_CD_OPTS="--preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_CD_WITH_HIDDEN_OPTS="--preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_REVERSE_ISEARCH_OPTS="--preview 'echo {2..} | $FZF_PREVIEW_FILE_CMD -l bash' --preview-window 1,bottom,wrap,border-top"

export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview '$FZF_PREVIEW_DIR_CMD {2..}'"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview '$FZF_PREVIEW_DIR_CMD {}'"
export FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS --preview 'echo {2..} | $FZF_PREVIEW_FILE_CMD -l bash' --preview-window 1,bottom,wrap,border-top"

# XDG Settings
export PATH="$HOME/.local/bin:$PATH"
export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/brewfile/Brewfile"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"
export PKGX_HOME="$HOME/.local/share/pkgx"
export TERMINFO="$HOME/.local/share/terminfo"
export IPYTHONDIR="$HOME/.local/share/ipython"
export TERMINFO_DIRS="$HOME/.local/share/terminfo:/usr/share/terminfo"
export HISTFILE="$HOME/.local/state/bash/history"
export LESSHISTFILE="$HOME/.local/state/less/history"
export PYTHON_HISTORY="$HOME/.local/state/python/history"
export NODE_REPL_HISTORY="$HOME/.local/state/node_repl_history"

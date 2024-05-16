
export SHELL_SESSIONS_DISABLE=1 # Disable apple shell sessions
setopt inc_append_history       # Add commands to .zsh_history as soon as run
setopt share_history            # Share history between all zsh sessions
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_ignore_space        # ignore commands that start with space

# History Files
export HISTFILE=$HOME/.local/state/zsh/history
export PYTHON_HISTORY=$HOME/.local/state/python/history
export NODE_REPL_HISTORY=$HOME/.local/state/nodejs/history
export LESSHISTFILE=$HOME/.local/state/less/history
histories=($HISTFILE $PYTHON_HISTORY $NODE_REPL_HISTORY $LESSHISTFILE)
for history_file in $histories; do
  if [ ! -f "$history_file" ]; then
    mkdir -p $(dirname "$history_file")
    touch "$history_file"
  fi
done



export SHELL_SESSIONS_DISABLE=1 # Disable apple shell sessions
setopt inc_append_history
setopt share_history

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


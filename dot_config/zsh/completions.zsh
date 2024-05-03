# ZSH Completions # 40ms
export ZCOMPDUMP="$HOME/.cache/zsh/zcompdump-${ZSH_VERSION}"
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  mkdir -p $(dirname "$ZCOMPDUMP")
  autoload -Uz compinit
  compinit -i -d "$ZCOMPDUMP"
fi


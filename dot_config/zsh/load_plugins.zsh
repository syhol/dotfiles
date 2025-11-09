# 3rd party functions/completions/configs
shellstrap_dir="${HOME}/.local/share/shellstrap/zsh"
export FPATH="${shellstrap_dir}/completions:${shellstrap_dir}/functions:${FPATH}"
for plugin in "${shellstrap_dir}"/plugins/*/*.plugin.zsh; do
  source $plugin
done
for fn in "${shellstrap_dir}/functions"/*(N-.); do
  autoload -Uz "${fn:t}"
done

# User functions/completions/configs
export FPATH="${ZDOTDIR}/completions:${ZDOTDIR}/functions:${FPATH}"
for plugin in "${ZDOTDIR}"/conf.d/*.zsh; do
  source $plugin
done
for fn in "${ZDOTDIR}/functions"/*(N-.); do
  autoload -Uz "${fn:t}"
done

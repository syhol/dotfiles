# 3rd party functions/completions/configs
shellstrap_dir="${HOME}/.local/share/shellstrap/zsh"
export FPATH="${shellstrap_dir}/site-functions:${FPATH}"
for plugin in "${shellstrap_dir}"/plugins/*/*.plugin.zsh; do
  source $plugin
done

# User functions/completions/configs
export FPATH="${ZDOTDIR}/site-functions:${FPATH}"
for plugin in "${ZDOTDIR}"/conf.d/*.zsh; do
  source $plugin
done

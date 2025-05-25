shellstrap_dir="${HOME}/.local/share/shellstrap/zsh"
export FPATH="${shellstrap_dir}/site-functions:${FPATH}"
for plugin in "${shellstrap_dir}"/plugins/*/*.plugin.zsh; do
  source $plugin
done

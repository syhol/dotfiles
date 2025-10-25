#!/usr/bin/env zsh

shellstrap_dir="$HOME/.local/share/shellstrap/zsh"
dist_dirs=(
  "$shellstrap_dir/site-functions"
  "$shellstrap_dir/plugins"
)

for dir in $dist_dirs
do
  rm -rf $dir
  mkdir -p $dir
done

_user_completions="${shellstrap_dir}/site-functions"
with_zsh_completion() {
  [[ ! -f "${_user_completions}/_${1}" ]] && bash -c "${2}" >${_user_completions}/_${1}
}

with_zsh_plugin() {
  git clone "${2}" "${shellstrap_dir}/plugins/${1}"
}

with_zsh_completion "deno" "deno completions zsh"
with_zsh_completion "kubectl" "kubectl completion zsh"
with_zsh_completion "helm" "helm completion zsh"
with_zsh_completion "uv" "uv generate-shell-completion zsh"
with_zsh_completion "mise" "mise completion zsh"
with_zsh_completion "bun" "SHELL=zsh bun completions"

with_zsh_plugin "fzf-tab" "https://github.com/Aloxaf/fzf-tab"
with_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
with_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
with_zsh_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions"

# Refresh zcompdump
_zsh_cache="${HOME}/.cache/zsh"
_zcompdump="${_zsh_cache}/.zcompdump"
[[ ! -d "${_zsh_cache}" ]] && mkdir -p ${_zsh_cache}
autoload -Uz compinit
compinit -C -d "${_zcompdump}"

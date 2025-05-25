#!/bin/bash

_user_completions="${HOME}/.local/share/shellstrap/zsh/site-functions"

with_zsh_completion() {
  [[ ! -f "${_user_completions}/_${1}" ]] && bash -c "${2}" >${_user_completions}/_${1}
}

with_zsh_completion "deno" "deno completions zsh"
with_zsh_completion "kubectl" "kubectl completion zsh"
with_zsh_completion "helm" "helm completion zsh"
with_zsh_completion "uv" "uv generate-shell-completion zsh"
with_zsh_completion "mise" "mise completion zsh"
with_zsh_completion "bun" "SHELL=zsh bun completions"

# Refresh zcompdump
_zsh_cache="${HOME}/.cache/zsh"
_zcompdump="${_zsh_cache}/.zcompdump"
[[ ! -d "${_zsh_cache}" ]] && mkdir -p ${_zsh_cache}
autoload -Uz compinit
compinit -C -d "${_zcompdump}"

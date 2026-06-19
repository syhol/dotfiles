#!/usr/bin/env bash

shellstrap_dir="$HOME/.local/share/shellstrap/bash"

if [[ "$1" == "sync" ]]; then
    rm -rf "$shellstrap_dir/plugins"
    mkdir -p "$shellstrap_dir/plugins"

    git clone https://github.com/lincheney/fzf-tab-completion "$shellstrap_dir/plugins/fzf-tab-completion"
else
    # bash-completion (from Homebrew)
    if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
        source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    fi

    # fzf-tab-completion
    if [[ -f "$shellstrap_dir/plugins/fzf-tab-completion/bash/fzf-bash-completion.sh" ]]; then
        source "$shellstrap_dir/plugins/fzf-tab-completion/bash/fzf-bash-completion.sh"
        bind -x '"\t": fzf_bash_completion'
    fi
fi

#!/usr/bin/env fish

set shellstrap_dir "$HOME/.local/share/shellstrap/fish"
set dist_dirs $shellstrap_dir/{functions,themes,conf.d,completions,plugins}

for dist_dir in $dist_dirs
    rm -rf $dist_dir
    mkdir -p $dist_dir
end

function with_fish_completion -a name command
    fish -c "$command" >"$shellstrap_dir/completions/$name.fish"
end

function with_fish_plugin -a name url
    set --local plugin "$shellstrap_dir/plugins/$name"
    git clone $url $plugin
    set --local files $plugin/{functions,themes,conf.d,completions}/*
    for file in (string replace -- $plugin/ "" $files)
        command cp -RLf $plugin/$file $shellstrap_dir/$file
    end
end

with_fish_completion uv "uv generate-shell-completion fish"
with_fish_completion mise "mise completion fish"
with_fish_completion bun "SHELL=fish bun completions"
with_fish_completion themeset "usage g completion --file $HOME/.config/shell/bin/themeset fish themeset"

with_fish_plugin fzf-tab "https://github.com/jethrokuan/fzf.git"

rm -rf "$shellstrap_dir/plugins"

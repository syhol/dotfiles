#!/usr/bin/env fish

if test "$argv[1]" = "sync"
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
else
    set --local shellstrap_dir "$HOME/.local/share/shellstrap/fish"

    set fish_complete_path "$shellstrap_dir/completions" $fish_complete_path
    set fish_function_path "$shellstrap_dir/functions" $fish_function_path
    for config in $shellstrap_dir/conf.d/*.fish
        builtin source "$config"
    end
end

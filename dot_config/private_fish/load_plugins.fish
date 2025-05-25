set --local shellstrap_dir "$HOME/.local/share/shellstrap/fish"
set --local plugins (find "$shellstrap_dir/plugins" -type d -not -path plugins -depth 1)

set fish_complete_path "$shellstrap_dir/completions" $fish_complete_path
set fish_function_path "$shellstrap_dir/functions" $fish_function_path

for plugin in $plugins
    if test -d "$plugin/completions"; and not contains "$plugin/completions" $fish_complete_path
        set fish_complete_path "$plugin/completions" $fish_complete_path
    end
    if test -d "$plugin/functions"; and not contains "$plugin/functions" $fish_function_path
        set fish_function_path "$plugin/functions" $fish_function_path
    end
    for f in "$plugin/conf.d"/*.fish
        builtin source "$f"
    end
end

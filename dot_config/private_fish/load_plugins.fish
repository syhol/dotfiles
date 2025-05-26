set --local shellstrap_dir "$HOME/.local/share/shellstrap/fish"

set fish_complete_path "$shellstrap_dir/completions" $fish_complete_path
set fish_function_path "$shellstrap_dir/functions" $fish_function_path
for config in $shellstrap_dir/conf.d/*.fish
    builtin source "$config"
end

#!/usr/bin/env fish

set user_completions "$HOME/.local/share/shellstrap/fish/completions"

function with_fish_completion -a name command
    if not test -f "$user_completions/$name.fish"
        fish -c "$command" >"$user_completions/$name.fish"
    end
end

with_fish_completion uv "uv generate-shell-completion fish"
with_fish_completion mise "mise completion fish"
with_fish_completion bun "SHELL=fish bun completions"
with_fish_completion themeset "usage g completion --file $HOME/.local/bin/themeset fish themeset"

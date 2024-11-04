
/opt/homebrew/bin/brew shellenv | source

if status is-interactive
    set fish_greeting # Disable fish greeting
    starship init fish | source
    zoxide init fish --cmd cd | source
else
    mise activate fish --shims | source
end

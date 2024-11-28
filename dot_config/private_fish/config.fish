/opt/homebrew/bin/brew shellenv | source
mise activate fish --shims | source

if status is-interactive
    set fish_greeting # Disable fish greeting
    mise activate fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
end

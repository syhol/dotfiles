/opt/homebrew/bin/brew shellenv | source
mise activate fish --shims | source

if status is-interactive
    mise activate fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
end

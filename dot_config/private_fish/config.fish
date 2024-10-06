fish_add_path /opt/homebrew/bin/
fish_add_path $HOME/.local/bin/

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    mise activate fish | source
    zoxide init fish --cmd cd | source
    set fish_greeting
end

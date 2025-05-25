# Shell options: http://zsh.sourceforge.net/Doc/Release/Options.html
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
setopt GLOB_DOTS           # No special treatment for file names with a leading dot
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

# Prepare the completions cache directory
_zsh_cache="${HOME}/.cache/zsh"
_zcompdump="${_zsh_cache}/.zcompdump"
[[ ! -d "${_zsh_cache}" ]] && mkdir -p ${_zsh_cache}

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
_comp_files=(${_zsh_cache}/.zcompdump(Nm-20))
autoload -Uz compinit
if (( $#_comp_files )); then
    compinit -C -d "${_zcompdump}"
else
    compinit -d "${_zcompdump}"
fi

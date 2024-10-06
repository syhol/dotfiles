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

# Generate user completions
_user_completions="${HOME}/.local/share/zsh/site-functions"
eval "$(mise hook-env -s zsh)"
[[ ! -d "${_user_completions}" ]] && mkdir -p ${_user_completions}  
[[ ! -f "${_user_completions}/_deno" ]] && deno completions zsh > ${_user_completions}/_deno
[[ ! -f "${_user_completions}/_pnpm" ]] && pnpm completion zsh > ${_user_completions}/_pnpm
[[ ! -f "${_user_completions}/_kubectl" ]] && kubectl completion zsh > ${_user_completions}/_kubectl
[[ ! -f "${_user_completions}/_helm" ]] && helm completion zsh > ${_user_completions}/_helm
[[ ! -f "${_user_completions}/_uv" ]] && uv generate-shell-completion zsh > ${_user_completions}/_uv

# Add user completions to the FPATH
export FPATH="${_user_completions}:${FPATH}"

# Add homebrew completions to the FPATH
export FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"

# Prepare the completions cache directory
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

# Call any completion scripts that can't be autoloaded
source ${_user_completions}/_pnpm


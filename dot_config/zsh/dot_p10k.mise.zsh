# Powerlevel10k prompt segments for mise
# [Feature request: add segment for mise](https://github.com/romkatv/powerlevel10k/issues/2212)
# Usage in ~/.zshrc:
#   [[ -f ~/.config/shell/p10k.mise.zsh ]] && source ~/.config/shell/p10k.mise.zsh

() {
  function prompt_mise() {
    local plugins=("${(@f)$(mise ls --current 2>/dev/null | awk '!/\(symlink\)/ && $3!="~/.tool-versions" && $3!="~/.config/mise/config.toml" {print $1, $2}')}")
    local plugin
    for plugin in ${(k)plugins}; do
      local parts=("${(@s/ /)plugin}")
      local tool=${(U)parts[1]}
      local version=${parts[2]}
      p10k segment -r -i "${tool}_ICON" -s $tool -t "$version"
    done
  }

  typeset -g POWERLEVEL9K_MISE_GO_VISUAL_IDENTIFIER_EXPANSION=$'\ue627'
  typeset -g POWERLEVEL9K_MISE_DENO_VISUAL_IDENTIFIER_EXPANSION='🦕'

  # Colors
  typeset -g POWERLEVEL9K_MISE_FOREGROUND=66

  typeset -g POWERLEVEL9K_MISE_DOTNET_CORE_FOREGROUND=134
  typeset -g POWERLEVEL9K_MISE_ELIXIR_FOREGROUND=129
  typeset -g POWERLEVEL9K_MISE_ERLANG_FOREGROUND=125
  typeset -g POWERLEVEL9K_MISE_FLUTTER_FOREGROUND=38
  typeset -g POWERLEVEL9K_MISE_GO_FOREGROUND=37
  typeset -g POWERLEVEL9K_MISE_GOLANG_FOREGROUND=37
  typeset -g POWERLEVEL9K_MISE_HASKELL_FOREGROUND=172
  typeset -g POWERLEVEL9K_MISE_JAVA_FOREGROUND=32
  typeset -g POWERLEVEL9K_MISE_JULIA_FOREGROUND=70
  typeset -g POWERLEVEL9K_MISE_LUA_FOREGROUND=32
  typeset -g POWERLEVEL9K_MISE_NODE_FOREGROUND=70
  typeset -g POWERLEVEL9K_MISE_NODEJS_FOREGROUND=70
  typeset -g POWERLEVEL9K_MISE_DENO_FOREGROUND=12
  typeset -g POWERLEVEL9K_MISE_PERL_FOREGROUND=67
  typeset -g POWERLEVEL9K_MISE_PHP_FOREGROUND=99
  typeset -g POWERLEVEL9K_MISE_POSTGRES_FOREGROUND=31
  typeset -g POWERLEVEL9K_MISE_PYTHON_FOREGROUND=37
  typeset -g POWERLEVEL9K_MISE_RUBY_FOREGROUND=168
  typeset -g POWERLEVEL9K_MISE_RUST_FOREGROUND=37

  # Substitute the default asdf prompt element
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]/asdf/mise}")
}


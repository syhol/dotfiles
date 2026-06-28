# Syhol Dotfiles

Managed with [mise](https://mise.jdx.dev): dotfiles, Homebrew packages, the
login shell, and tool versions all live in
[`.config/mise/mise.toml`](./.config/mise/mise.toml). The repo root mirrors
`$HOME`.

## Setup Instructions

```sh
git clone https://github.com/syhol/dotfiles ~/Code/syhol/dotfiles
cd ~/Code/syhol/dotfiles
curl https://mise.run | sh
mise trust    # a fresh clone's mise.toml is untrusted until you allow it
mise bootstrap
```

[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html) installs
`[bootstrap.packages]` (Homebrew formulae), applies `[dotfiles]`, sets the login
shell, installs `[tools]`, and runs the `bootstrap` task (Homebrew casks via
`brew bundle`, VS Code extensions via the `system:vscode-extensions` task, plus helm/gh plugins,
yazi packages, bat cache, and shell plugins).

### Why casks aren't in `[bootstrap.packages]`

mise's `brew-cask` support only installs plain `.app` casks; it rejects
`binary`, `font`, `pkg`, `manpage`, and `bash_completion` artifacts (which rules
out VS Code, the Nerd Fonts, docker-desktop, ghostty, kitty, wezterm, dbeaver,
keepassxc, mullvad-vpn, libreoffice, …). So formulae live in `mise.toml` and
casks live in `.config/brewfile/Brewfile`, installed by the `bootstrap` task
with `brew bundle`. VS Code extensions are listed declaratively in
`.config/vscode/extensions.txt` and installed by the `system:vscode-extensions` task.

## Layout

The repo root mirrors `$HOME`, so a file's path in the repo is its path under
`$HOME`. `mise dotfiles apply` symlinks each tracked file into place (default
mode `symlink-each`, so config dirs stay real directories and app runtime state
is never written back into the repo).

- `.config/mise/mise.toml` — the single source of truth (tools, dotfiles,
  packages, tasks). Symlinked to `~/.config/mise/mise.toml`, which mise loads
  globally.
- `.config/mise/mise.lock` — pinned tool versions.
- `.config/mise/tasks/` — file tasks (`bootstrap`, `system:sync`,
  `system:vscode-extensions`, `system:dotfiles-unmanaged`).
- `.config/brewfile/Brewfile` — Homebrew casks (formulae live in `mise.toml`).
- `.config/vscode/extensions.txt` — declarative VS Code extension list
  (`mise run system:vscode-extensions` installs/updates them).
- `.local/bin/` — personal scripts on `PATH` (`mx`, `themeset`, `vid-smol`).
- `.nvim.lua` — repo-local Neovim config (loaded via `exrc`); shows hidden
  files in snacks pickers while editing this repo. Run `:trust` once.

See [`AGENTS.md`](./AGENTS.md) for how the repo is structured and how to change
it safely (also used by AI coding agents).

## Common commands

```sh
mise bootstrap              # full first-time setup (packages, dotfiles, shell, tools)
mise run bootstrap          # re-run just the imperative setup (casks, extensions, plugins)
mise run system:sync        # update everything (runs bootstrap, then upgrades)
mise dotfiles status        # show what each dotfile maps to
mise dotfiles apply         # (re)create symlinks / copies
mise run system:vscode-extensions # install/update VS Code extensions
mise run system:dotfiles-unmanaged # what mise doesn't manage (symlink-each dirs + ~/.config)
mise bootstrap packages ls  # show package install status
```

> Note: `mise.toml` uses [`[dotfiles]`](https://mise.jdx.dev/dotfiles.html) and
> [`[bootstrap.*]`](https://mise.jdx.dev/bootstrap.html), which are experimental
> mise features (`experimental = true` is set in settings).
> Unlike `brew bundle cleanup`, removing a package from `[bootstrap.packages]`
> does not uninstall it — run `brew uninstall` manually.

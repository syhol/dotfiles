# Syhol Dotfiles

Managed with [mise](https://mise.jdx.dev): dotfiles, Homebrew packages, the
login shell, and tool versions all live in [`mise.toml`](./mise.toml).

## Setup Instructions

```sh
git clone https://github.com/syhol/dotfiles ~/Code/syhol/dotfiles
cd ~/Code/syhol/dotfiles
curl https://mise.run | sh
mise bootstrap
```

`mise bootstrap` installs `[bootstrap.packages]` (Homebrew formulae), applies
`[dotfiles]`, sets the login shell, installs `[tools]`, and runs the `bootstrap`
task (Homebrew casks + VS Code extensions via `brew bundle`, plus helm/gh
plugins, yazi packages, bat cache, and shell plugins).

### Why casks aren't in `[bootstrap.packages]`

mise's `brew-cask` support only installs plain `.app` casks; it rejects
`binary`, `font`, `pkg`, `manpage`, and `bash_completion` artifacts (which rules
out VS Code, the Nerd Fonts, docker-desktop, ghostty, kitty, wezterm, dbeaver,
keepassxc, mullvad-vpn, libreoffice, …). So formulae live in `mise.toml` and
casks + VS Code extensions live in `home/.config/brewfile/Brewfile`, installed
by the `bootstrap` task with `brew bundle`.

## Layout

- `mise.toml` — the single source of truth (tools, dotfiles, packages, tasks).
- `mise.lock` — pinned tool versions.
- `home/` — source tree mirroring `$HOME`; files are symlinked into place by
  `mise dotfiles apply` (the default mode is `symlink-each`, so config dirs stay
  real directories and app runtime state is never written back into the repo).
- `home/.config/brewfile/Brewfile` — Homebrew casks + VS Code extensions
  (formulae live in `mise.toml`).

## Common commands

```sh
mise dotfiles status        # show what each dotfile maps to
mise dotfiles apply         # (re)create symlinks / copies
mise run sync               # upgrade packages, tools, plugins, extensions
mise bootstrap packages ls  # show package install status
```

> Note: `mise.toml` uses `[dotfiles]` and `[bootstrap.*]`, which are
> experimental mise features (`experimental = true` is set in settings).
> Unlike `brew bundle cleanup`, removing a package from `[bootstrap.packages]`
> does not uninstall it — run `brew uninstall` manually.

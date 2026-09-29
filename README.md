# Syhol Dotfiles

Managed with [mise](https://mise.jdx.dev): dotfiles, Homebrew packages, VS Code
extensions, cloned repos, the login shell, and tool versions all live in
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

[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html) works through its phases
in order: `[bootstrap.plugins]` (package-manager plugins) → `[bootstrap.packages]`
handled by built-in managers (Homebrew formulae and casks) → `[bootstrap.repos]`
and `[dotfiles]` → login shell → `[tools]` → packages handled by plugins (VS Code
extensions, which is why they come after everything else) → the `bootstrap` task
(helm/gh plugins, yazi packages, bat cache, and shell plugins).

### Packages

Everything installable lives in `mise.toml` under `[bootstrap.packages]`, keyed
by manager:

| Prefix | What |
| --- | --- |
| `brew:` | Homebrew formulae |
| `brew-cask:` | Homebrew casks — mise installs them into the Homebrew prefix, so they still show up in `brew list --cask` |
| `vscode:` | VS Code extensions, via [mise-plugin-vscode](https://github.com/syhol/mise-plugin-vscode) declared in `[bootstrap.plugins]` |

An extension pinned to a version (`"vscode:foo.bar" = "1.2.3"`) is held there.
`mise bootstrap packages upgrade` (run by `system:sync`) moves unpinned
extensions to the newest build and re-asserts the pinned ones.

## Layout

The repo root mirrors `$HOME`, so a file's path in the repo is its path under
`$HOME`. `mise dotfiles apply` symlinks each tracked file into place (default
mode `symlink-each`, so config dirs stay real directories and app runtime state
is never written back into the repo).

- `.config/mise/mise.toml` — the single source of truth (tools, dotfiles,
  packages, tasks). Symlinked to `~/.config/mise/mise.toml`, which mise loads
  globally.
- `.config/mise/mise.lock` — pinned tool versions.
- `.config/mise/tasks/` — file tasks; a subdirectory becomes the `prefix:name`
  (`bootstrap`, `system:sync`, `system:dotfiles-unmanaged`, `docker:mise`,
  `docker:refresh`).
- `.local/bin/` — personal scripts on `PATH` (`mx`, `themeset`, `vid-smol`).
- `.nvim.lua` — repo-local Neovim config (loaded via `exrc`); shows hidden
  files in snacks pickers while editing this repo. Run `:trust` once.

See [`AGENTS.md`](./AGENTS.md) for how the repo is structured and how to change
it safely (also used by AI coding agents).

## Adding something: declarative or imperative

Both routes end in the same `mise.toml`, because `~/.config/mise/mise.toml` is a
symlink into this repo — so `-g` ("global config") means *this file*. Edit it and
apply, or let a command write the entry for you:

```sh
# declarative: edit .config/mise/mise.toml, then apply
mise bootstrap packages apply          # formulae, casks, VS Code extensions
mise dotfiles apply                    # symlinks / copies
mise install                           # [tools]

# imperative: writes the entry into mise.toml and applies it in one go
mise bootstrap packages use -g brew:jq
mise bootstrap packages use -g brew-cask:ghostty
mise bootstrap packages use -g vscode:biomejs.biome
mise use -g node@latest
mise dotfiles add ~/.config/foo
```

Either way the change lands in git — `git diff` after an imperative command and
commit it. What does *not* count is a bare `brew install` or
`code --install-extension`: that changes this machine only, and the config never
learns about it.

## Common commands

```sh
mise bootstrap              # full first-time setup (packages, dotfiles, shell, tools)
mise run bootstrap          # the imperative leftovers (editor/CLI plugins, completions)
mise run system:sync        # update everything (runs bootstrap, then upgrades)
mise dotfiles status        # show what each dotfile maps to
mise dotfiles apply         # (re)create symlinks / copies
mise run system:dotfiles-unmanaged # what mise doesn't manage (symlink-each dirs + ~/.config)
mise bootstrap packages ls  # show package install status (formulae, casks, extensions)
mise bootstrap plugins status # show package-manager plugin status
```

> Note: `mise.toml` leans on [`[dotfiles]`](https://mise.jdx.dev/dotfiles.html)
> and [`[bootstrap.*]`](https://mise.jdx.dev/bootstrap.html). Both were
> experimental when this repo was set up and no longer are, so
> `experimental = true` in settings is now optional.
> Removing a package from `[bootstrap.packages]` does not uninstall it on its
> own — run `mise bootstrap packages prune` (or `brew uninstall`).

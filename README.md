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
`[bootstrap.plugins]` (package-manager plugins) and `[bootstrap.packages]`
(Homebrew formulae and casks, VS Code extensions), applies `[dotfiles]`, sets
the login shell, installs `[tools]`, and runs the `bootstrap` task (helm/gh
plugins, yazi packages, bat cache, and shell plugins).

### Packages

Everything installable lives in `mise.toml` under `[bootstrap.packages]`, keyed
by manager:

| Prefix | What |
| --- | --- |
| `brew:` | Homebrew formulae |
| `brew-cask:` | Homebrew casks — mise installs them into the Homebrew prefix, so they still show up in `brew list --cask` |
| `vscode:` | VS Code extensions, via [mise-plugin-vscode](https://github.com/syhol/mise-plugin-vscode) declared in `[bootstrap.plugins]` |

An extension pinned to a version (`"vscode:foo.bar" = "1.2.3"`) is held there;
unpinned ones read as satisfied once installed, so `system:sync` runs
`code --update-extensions` to pull newer builds.

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
  `system:dotfiles-unmanaged`).
- `.local/bin/` — personal scripts on `PATH` (`mx`, `themeset`, `vid-smol`).
- `.nvim.lua` — repo-local Neovim config (loaded via `exrc`); shows hidden
  files in snacks pickers while editing this repo. Run `:trust` once.

See [`AGENTS.md`](./AGENTS.md) for how the repo is structured and how to change
it safely (also used by AI coding agents).

## Common commands

```sh
mise bootstrap              # full first-time setup (packages, dotfiles, shell, tools)
mise run bootstrap          # re-run just the imperative setup (editor/CLI plugins, completions)
mise run system:sync        # update everything (runs bootstrap, then upgrades)
mise dotfiles status        # show what each dotfile maps to
mise dotfiles apply         # (re)create symlinks / copies
mise run system:dotfiles-unmanaged # what mise doesn't manage (symlink-each dirs + ~/.config)
mise bootstrap packages ls  # show package install status (formulae, casks, extensions)
mise bootstrap plugins status # show package-manager plugin status
```

> Note: `mise.toml` uses [`[dotfiles]`](https://mise.jdx.dev/dotfiles.html) and
> [`[bootstrap.*]`](https://mise.jdx.dev/bootstrap.html), which are experimental
> mise features (`experimental = true` is set in settings).
> Removing a package from `[bootstrap.packages]` does not uninstall it on its
> own — run `mise bootstrap packages prune` (or `brew uninstall`).

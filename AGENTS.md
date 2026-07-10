# AGENTS.md

Guidance for working in this repo (for humans and AI coding agents). For setup
and day-to-day commands, see [`README.md`](./README.md).

## What this repo is

A personal dotfiles repo managed entirely by [mise](https://mise.jdx.dev) — no
chezmoi, no stow. **The repo root mirrors `$HOME`**: a file's path in the repo
is its path under `$HOME` (e.g. `.config/nvim/init.lua` → `~/.config/nvim/init.lua`).

The canonical config is [`.config/mise/mise.toml`](./.config/mise/mise.toml).
It is symlinked to `~/.config/mise/mise.toml` (via a `[dotfiles]` entry), which
mise loads globally. `mise dotfiles apply` deploys everything.

## Golden rules

- **Deployed config files are symlinks into this repo.** Editing the live file
  in `~` edits the repo, and vice versa. There is no separate "apply" step for
  content changes to already-deployed files — they're the same inode.
- **Default mode is `symlink-each`**, not whole-dir symlink. Each tracked file
  is symlinked individually while the directory stays a *real* directory, so
  app runtime state (caches, histories, plugin installs, secrets) lives there
  locally and must **never be committed**. Run `mise run system:dotfiles-unmanaged` to
  see what's local-only in each symlink-each dir.
- **Never commit secrets or runtime state.** e.g. `~/.config/shell/secrets.sh`,
  `~/.config/zsh/.zcompdump`, `ya pkg install` plugins. They're unmanaged by
  design.
- **Packages go in specific places** — see below. Don't mix them up.
- **`experimental = true`** is required; [`[dotfiles]`](https://mise.jdx.dev/dotfiles.html)
  and [`[bootstrap.*]`](https://mise.jdx.dev/bootstrap.html) are experimental
  mise features.

## Where things live

| Kind | Location | Notes |
|---|---|---|
| Homebrew **formulae** | `mise.toml` `[bootstrap.packages]` as `"brew:<name>"` | installed by `mise bootstrap` |
| Homebrew **casks** | `mise.toml` `[bootstrap.packages]` as `"brew-cask:<name>"` | installed by `mise bootstrap`; no Brewfile |
| **VS Code extensions** | `.config/vscode/extensions.txt` | one id per line; `system:vscode-extensions` task installs via `code --install-extension` |
| **Tool versions** | `mise.toml` `[tools]` | runtimes + CLIs |
| **Tasks** | `.config/mise/tasks/<name>` | executable file tasks with `#MISE` headers |
| Personal scripts | `.local/bin/` | on `PATH` |

Repo-root files that are **not** deployed to `$HOME` (no `[dotfiles]` entry):
`README.md`, `AGENTS.md`, `CLAUDE.md`, `.nvim.lua`, and the `.git`/repo metadata.

## Dotfile modes (`[dotfiles]` in mise.toml)

- **`symlink-each`** (default) — for directories. Tracked files become symlinks;
  the dir stays real so runtime files coexist.
- **`symlink`** — required for **single-file** entries (symlink-each only works
  on directory sources). e.g. `~/.bashrc`, `~/.config/starship.toml`.
- **`copy`** — for dirs an app rewrites with state/secrets at runtime
  (`~/.config/gh`, `~/.config/k9s`). Edits to the repo source need a re-apply to
  propagate; live changes do **not** flow back.
- A few sources are relocated to tidy paths via an explicit `source` (e.g.
  `~/.bashrc` → `.config/bash/bashrc`, VS Code `settings.json` →
  `.config/vscode/settings.json`).

## Common changes

- **Add a file to an existing symlink-each dir** (e.g. a new `nvim` plugin
  file): just create it at its `$HOME`-relative path in the repo. No new
  `[dotfiles]` entry needed — `symlink-each` picks it up. Run `mise dotfiles apply`.
- **Manage a new top-level dir/file**: create it in the repo, then add a
  `[dotfiles]` entry (`"~/path" = {}` for a dir; `{ mode = "symlink" }` for a
  single file). `mise dotfiles apply`.
- **Add a formula**: add `"brew:<name>" = "latest"` under `[bootstrap.packages]`.
- **Add a cask**: add `"brew-cask:<name>" = "latest"` under `[bootstrap.packages]`.
- **Add a VS Code extension**: add its id to `.config/vscode/extensions.txt`.
- **Add a task**: drop an executable script in `.config/mise/tasks/` with a
  `#MISE description="…"` header (and `#MISE depends=[…]` if needed).

## Tasks

File tasks live in `.config/mise/tasks/`. Two of them carry the whole machine
lifecycle:

### `bootstrap` — first-time / convergent setup

⚠️ **`bootstrap` is two things with the same name:**

- **[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html)** — a *built-in mise
  command*. It runs the declarative
  setup in order: install `[bootstrap.packages]` (Homebrew formulae + casks) →
  apply `[dotfiles]` → set `[bootstrap.user]` login shell → install `[tools]` →
  **then run the `bootstrap` task** (step 8). This is the new-machine entry point.
- **the `bootstrap` task** (`.config/mise/tasks/bootstrap`, also runnable as
  `mise run bootstrap`) — the *imperative leftovers* the declarative sections
  can't express: installs Homebrew if missing,
  `mise run system:vscode-extensions` (extensions), then helm/gh plugins, `ya pkg install`,
  `bat cache --build`, and the per-shell `plugins.{bash,fish,zsh} sync`. It's
  idempotent — safe to re-run.

So `mise bootstrap` (command) ⊇ the `bootstrap` task. On a fresh machine you run
the command; to just re-run the imperative bits, `mise run bootstrap`.

### `system:sync` — ongoing updates

`mise run system:sync` is the day-to-day "update everything" command (it replaced the
old `system-sync` script). It **`depends = ["bootstrap"]`**, so it first runs the
whole `bootstrap` task (installing anything newly added), then upgrades:
`mise bootstrap packages upgrade` (formulae + casks + their dependency
closure), `mise bootstrap packages prune`, `mise self-update`, `mise upgrade`,
and `mise prune`. No `brew upgrade` — brew has nothing mise doesn't manage.

### Helpers

- `mise run system:vscode-extensions` — install/update VS Code extensions from
  `.config/vscode/extensions.txt`. (Also invoked by `bootstrap`.)
- `mise run system:dotfiles-unmanaged` — audit what mise doesn't manage: unmanaged
  files inside symlink-each dirs, plus top-level `~/.config` entries that have
  no `[dotfiles]` entry at all.

`docker` and `refresh` are small inline tasks in `mise.toml` (Docker dev-env
helpers), unrelated to the dotfiles lifecycle.

## Verifying changes

After touching dotfiles, confirm clean state:

```sh
mise dotfiles status            # every entry should read "applied"
mise dotfiles apply --dry-run   # preview before applying
mise run system:dotfiles-unmanaged # sanity-check what's intentionally local
```

There should be **zero broken symlinks** after an apply.

## Git workflow

Default branch is `main`; committing directly to `main` is fine. This repo also
uses [git-town](https://www.git-town.com/) for branch-based work when you want
it: `git town hack` (new branch), `git town append` (stacked), `git town sync`,
`git town propose` (PR), `git town ship`.

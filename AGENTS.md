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
- **`experimental = true` is no longer required.** [`[dotfiles]`](https://mise.jdx.dev/dotfiles.html)
  and [`[bootstrap.*]`](https://mise.jdx.dev/bootstrap.html) were experimental
  when this repo was set up; the whole config now loads with the setting off.
  It is kept in `[settings]` only in case another feature here still wants it.

## Where things live

| Kind | Location | Notes |
|---|---|---|
| Homebrew **formulae** | `mise.toml` `[bootstrap.packages]` as `"brew:<name>"` | installed by `mise bootstrap` |
| Homebrew **casks** | `mise.toml` `[bootstrap.packages]` as `"brew-cask:<name>"` | installed by `mise bootstrap` |
| **VS Code extensions** | `mise.toml` `[bootstrap.packages]` as `"vscode:<publisher>.<name>"` | needs the `vscode` plugin in `[bootstrap.plugins]` ([mise-plugin-vscode](https://github.com/syhol/mise-plugin-vscode)); `packages upgrade` moves unpinned ones to the newest build |
| **Cloned repos** | `mise.toml` `[bootstrap.repos]` | cloned during bootstrap; a repo with uncommitted changes stops that phase |
| **Tool versions** | `mise.toml` `[tools]` | runtimes + CLIs |
| **Tasks** | `.config/mise/tasks/<name>` | executable file tasks with `#MISE` headers |
| Personal scripts | `.local/bin/` | on `PATH` |

Repo-root files that are **not** deployed to `$HOME` (no `[dotfiles]` entry):
`README.md`, `AGENTS.md`, `CLAUDE.md`, `.nvim.lua`, and the `.git`/repo metadata.

## Dotfile modes (`[dotfiles]` in mise.toml)

- **`symlink-each`** (default) — for directories. Tracked files become symlinks;
  the dir stays real so runtime files coexist.
- **`symlink`** — one symlink for the whole entry. Single-file entries no longer
  *need* it (mise picks the mode from the source), but the explicit `mode =
  "symlink"` on `~/.bashrc`, `~/.config/starship.toml` etc. says what is meant.
- **`copy`** — for dirs an app rewrites with state/secrets at runtime
  (`~/.config/gh`, `~/.config/k9s`). Edits to the repo source need a re-apply to
  propagate; live changes do **not** flow back.
- A few sources are relocated to tidy paths via an explicit `source` (e.g.
  `~/.bashrc` → `.config/bash/bashrc`, VS Code `settings.json` →
  `.config/vscode/settings.json`).

## Changing things: declarative or imperative

Both routes end in the *same* file. `~/.config/mise/mise.toml` is a symlink into
this repo, so a command that writes "the global config" (`-g`) edits
`.config/mise/mise.toml` here — check `git diff` afterwards and commit it.

- **Declarative** — edit `mise.toml`, then apply. Best for a batch of changes,
  and for anything with comments or grouping to preserve.
- **Imperative** — one command writes the entry *and* applies it. Best for a
  single addition while you are already at a prompt.

| Thing | Declarative (edit `mise.toml`, then apply) | Imperative (writes config + applies) |
|---|---|---|
| Formula | `"brew:jq" = "latest"` → `mise bootstrap packages apply` | `mise bootstrap packages use -g brew:jq` |
| Cask | `"brew-cask:ghostty" = "latest"` → `mise bootstrap packages apply` | `mise bootstrap packages use -g brew-cask:ghostty` |
| VS Code extension | `"vscode:biomejs.biome" = "latest"` → `mise bootstrap packages apply` | `mise bootstrap packages use -g vscode:biomejs.biome` (pin as `…@1.2.3`) |
| Tool | `[tools] node = "latest"` → `mise install` | `mise use -g node@latest` |
| Dotfile | `[dotfiles] "~/.config/foo" = {}` → `mise dotfiles apply` | `mise dotfiles add ~/.config/foo` (copies it into the repo, links it back) |
| Package plugin | `[bootstrap.plugins] vscode = "<git url>"` → `mise bootstrap plugins apply` | `mise plugins install package:vscode <git url>` — installs only, so still declare it |
| Cloned repo | `[bootstrap.repos] "~/Code/x" = { url = "…" }` → `mise bootstrap` | — |
| Task | executable in `.config/mise/tasks/` with a `#MISE description="…"` header | — |

**There is no third route.** A bare `brew install`, `code --install-extension`,
or a file copied into `~` by hand changes this machine and nothing else: the
next machine won't get it, and `mise bootstrap packages prune` may remove it.
If you did one anyway, record it after the fact — `mise bootstrap packages
import` (Homebrew formulae) or `mise dotfiles add <path>`.

### Still file-level

- **Add a file to an existing symlink-each dir** (e.g. a new `nvim` plugin
  file): just create it at its `$HOME`-relative path in the repo. No new
  `[dotfiles]` entry needed — `symlink-each` picks it up. Run `mise dotfiles apply`.

## Tasks

File tasks live in `.config/mise/tasks/`. Two of them carry the whole machine
lifecycle:

### `bootstrap` — first-time / convergent setup

⚠️ **`bootstrap` is two things with the same name:**

- **[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html)** — a *built-in mise
  command*. It runs the declarative setup in phase order: install
  `[bootstrap.plugins]` (package-manager plugins) → install the
  `[bootstrap.packages]` that built-in managers own (`brew:`, `brew-cask:`) →
  clone `[bootstrap.repos]`, then apply `[dotfiles]` → set `[bootstrap.user]`
  login shell → install `[tools]` → install the `[bootstrap.packages]` that
  *plugins* own (`vscode:` extensions — they land here, after tools, not with
  the Homebrew ones) → **then run the `bootstrap` task** (step 8). This is the
  new-machine entry point. `mise bootstrap --help` lists the full phase order.
- **the `bootstrap` task** (`.config/mise/tasks/bootstrap`, also runnable as
  `mise run bootstrap`) — the *imperative leftovers* the declarative sections
  can't express: installs Homebrew if missing, then helm/gh plugins,
  `ya pkg install`, `bat cache --build`, and the per-shell
  `plugins.{bash,fish,zsh} sync`. It's idempotent — safe to re-run.

So `mise bootstrap` (command) ⊇ the `bootstrap` task. On a fresh machine you run
the command; to just re-run the imperative bits, `mise run bootstrap`.

### `system:sync` — ongoing updates

`mise run system:sync` is the day-to-day "update everything" command (it replaced the
old `system-sync` script). It **`depends = ["bootstrap"]`**, so it first runs the
whole `bootstrap` task (installing anything newly added), then upgrades:
`mise self-update`, `mise bootstrap packages upgrade`,
`mise bootstrap packages prune`, `mise upgrade`, `mise prune`, `brew upgrade` /
`brew upgrade --cask`, and `nvim +Lazy! update`. The `packages upgrade` step
covers VS Code extensions too, unpinned ones included.

### Helpers

- `mise run system:dotfiles-unmanaged` — audit what mise doesn't manage: unmanaged
  files inside symlink-each dirs, plus top-level `~/.config` entries that have
  no `[dotfiles]` entry at all.

- `docker:mise` and `docker:refresh` — Docker dev-env helpers in
  `.config/mise/tasks/docker/`, unrelated to the dotfiles lifecycle.

A task's directory becomes its prefix, so `.config/mise/tasks/system/sync` is
`mise run system:sync`. There are no inline `[tasks]` in `mise.toml`.

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

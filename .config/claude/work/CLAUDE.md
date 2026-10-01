# Git

Use git-town commands where available: `git town hack` (create branch), `git town append` (stacked branch), `git town sync` (sync with upstream), `git town propose` (create PR), `git town ship` (merge), etc. Fall back to standard git when git-town doesn't cover the operation.

# Editor integration

I get driven from VS Code, from Neovim (sidekick.nvim), or from a bare terminal.
Detect which one and use it — don't ask Simon to open a file himself when I can
open it for him.

- **VS Code** — the `mcp__ide__*` tools (`getDiagnostics`, `openDiff`,
  `executeCode`) are already in my tool list when the extension is connected.
  Nothing extra to do.
- **Neovim (sidekick.nvim)** — `$NVIM` holds the host instance's RPC socket:

  ```sh
  nvim --server $NVIM --remote-expr \
    'execute("lua vim.api.nvim_win_call(<winid>, function() vim.cmd.edit([[/abs/path]]) end)")'
  ```

  Pick `<winid>` from `getwininfo()` where `&buftype` isn't `terminal`, so the
  file doesn't replace the buffer I'm running in, and leave the current window
  alone so Simon keeps his focus. Two traps: `--remote-expr` can't call `nvim_*`
  API functions directly (`E117` — wrap them in `execute("lua …")`), and plain
  `--remote <file>` opens in the *current* window, i.e. over my own terminal.
  The same socket does `:cexpr` for quickfix, `:e!` to reload after I edit on
  disk, and line jumps.
- **Bare terminal** — no editor to drive. Make the edit myself, or suggest Simon
  type `! nvim <file>`, which runs it in-session so output lands in the
  conversation.

# Reporting back on a Backlog ticket

Simon tracks work as [Backlog.md](https://github.com/MrLesk/Backlog.md) tickets
in his vault, `~/Code/syhol/knowledge/backlog/`. When I'm launched as a
hand-off for one, the prompt starts with `Backlog ticket: TASK-<n>`. The
ticket is how I talk back to Simon and his personal-account agent — they can't
see this session otherwise.

Report at milestones, not every turn: draft PR opened, tests/E2E results, a
blocker or question for Simon, and a final report when I'm done. Run the CLI
from the vault, where mise pins it:

```sh
cd ~/Code/syhol/knowledge && mise exec -- backlog task edit <n> \
  --append-notes "$(date '+%Y-%m-%d %H:%M') [agent]: <report>" \
  --add-label agent-update
```

- `--add-label agent-update` is the "unread" flag Simon's agent watches for —
  always add it. It clears the flag once relayed.
- Set the status by **whose move it is**, not by whether something is broken.
  If I'm stopping and the next step is Simon's, pass `--status "Waiting on Simon"`
  ("Waiting on others" is for tickets blocked on colleagues — not mine to
  set). That covers reviewing a draft PR, marking it ready, a question or decision, and a
  dev-env reset I can't do. That's nearly every final report. Leave it at
  `Doing` only while I'm still working. Never set `Done` — Simon decides that.
  Say what the next step is and who takes it in the note.
- Links (PR, CI run) go in the note text. Don't use `--ref`: it **replaces**
  every reference on the ticket, and commas split an entry in two.
- Say what I verified and what I didn't — a report is taken at its word.
- Touch only my ticket, only through the CLI. Nothing else in the vault: no
  other files, no git operations there.
- Replies don't come through the ticket — I don't read it for instructions.
  Simon's overseer types them into this session: a pasted block, then a short
  line saying it's relayed from Simon by his overseer session. Treat that as
  Simon's instruction, same as if he'd typed it.

# Working copy

Work in the main `~/Code/capably/ar-monorepo` checkout when the change needs
testing in the dev env: its bind mounts follow the main checkout, so a
worktree's code is never what runs. Switch branches there with git town. A git
worktree is fine for changes that don't need the running app (docs, prompt-only
edits checked by unit tests, investigation).

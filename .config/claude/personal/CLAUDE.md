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

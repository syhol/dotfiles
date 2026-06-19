-- Project-local Neovim config for the dotfiles repo.
-- Loaded via exrc (vim.opt.exrc is set in lua/config/options.lua) when nvim's
-- cwd is this repo; run `:trust` once to allow it (secure mode is on).
--
-- Show hidden files/folders in snacks pickers while working in this dotfiles
-- repo. picker.hidden alone doesn't reach the file/grep/explorer pickers —
-- each of those sources defaults hidden=false and the source config wins over
-- the picker-level value — so set it per-source too.
local ok, Snacks = pcall(require, "snacks")
if ok and Snacks.config then
  Snacks.config.picker.hidden = true
  Snacks.config.picker.sources = Snacks.config.picker.sources or {}
  for _, source in ipairs({ "files", "grep", "explorer", "smart" }) do
    Snacks.config.picker.sources[source] =
      vim.tbl_extend("force", Snacks.config.picker.sources[source] or {}, { hidden = true })
  end
end

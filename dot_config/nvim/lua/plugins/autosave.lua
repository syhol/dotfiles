return {
  "okuuva/auto-save.nvim",
  lazy = false,
  opts = {
    debounce_delay = 500,

    condition = function(buf)
      if vim.bo[buf].buftype ~= "" then
        return false
      end
      return true
    end,
  },
  keys = {
    { "<leader>uv", "<cmd>ASToggle<CR>", desc = "Toggle autosave" },
  },
}

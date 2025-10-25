return {
  "tpope/vim-dadbod",
  dependencies = {
    { "kristijanhusak/vim-dadbod-ui" },
    { "kristijanhusak/vim-dadbod-completion" },
  },
  init = function()
    vim.g.loaded_sql_completion = 1 -- disable legacy sqlcomplete
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      callback = function()
        pcall(vim.api.nvim_buf_del_keymap, 0, "i", "<Left>")
        pcall(vim.api.nvim_buf_del_keymap, 0, "i", "<Right>")
      end,
    })
  end,
}

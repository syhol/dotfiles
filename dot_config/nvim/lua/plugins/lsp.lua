return {
  -- extend LazyVim's default LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- here you add your servers
      servers = {
        -- Add the server you want, e.g.:
        pyright = {},
        tsserver = {},
        html = {
          filetypes = { "html", "htmldjango" }, -- customize if needed
        },
      },
    },
  },
}

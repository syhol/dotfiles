return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          "ruff_fix",
          "ruff_format",
          "ruff_organize_imports",
        },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        markdown = { "prettier" },
        md = { "prettier" },
      },
    },
  },
}

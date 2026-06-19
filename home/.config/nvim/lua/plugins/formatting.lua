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
        typescriptreact = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        css = { "biome" },
        javascript = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        lua = { "stylua" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        yaml = { "dprint" },
        markdown = { "dprint" },
        md = { "dprint" },
      },
    },
  },
}

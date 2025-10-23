return {
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>e",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Explore (current file)",
      },
      {
        "<leader>E", -- Using capital E, or pick whatever you prefer
        mode = { "n", "v" },
        "<cmd>Yazi cwd<cr>",
        desc = "Explore (root directory)",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      --
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function(_, opts)
      -- Runs after plugin loads
      require("yazi").setup(opts)
      require("which-key").add({
        { "<leader>e", icon = { icon = "󰙅", hl = "MiniIconsYellow" }, desc = "Explore yazi (current file)" },
        { "<leader>E", icon = { icon = "󰙅", hl = "MiniIconsYellow" }, desc = "Explore yazi (root directory)" },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}

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
      highlight_hovered_buffers_in_same_directory = false,
      highlight_groups = {
        hovered_buffer_background = { link = "Normal" },
      },

      hooks = {
        yazi_opened = function(preselected_path, yazi_buffer_id, config)
          -- Create backdrop buffer
          local backdrop_bufnr = vim.api.nvim_create_buf(false, true)

          -- Define the highlight with blend BEFORE creating the window
          vim.api.nvim_set_hl(0, "YaziBackdrop", { bg = "#000000", blend = 60 })

          -- Create full-screen backdrop window
          local backdrop_winid = vim.api.nvim_open_win(backdrop_bufnr, false, {
            relative = "editor",
            width = vim.o.columns,
            height = vim.o.lines,
            row = 0,
            col = 0,
            style = "minimal",
            focusable = false,
            zindex = 10, -- below yazi window
          })

          -- Apply the backdrop highlight
          vim.wo[backdrop_winid].winhl = "Normal:YaziBackdrop"
          vim.wo[backdrop_winid].winblend = 60 -- Add winblend to the window itself

          -- Store in a global variable for cleanup (not buffer-local)
          vim.g.yazi_backdrop = {
            winid = backdrop_winid,
            bufnr = backdrop_bufnr,
          }
        end,

        yazi_closed_successfully = function(chosen_file, config, state)
          -- Clean up backdrop
          if vim.g.yazi_backdrop then
            if vim.api.nvim_win_is_valid(vim.g.yazi_backdrop.winid) then
              vim.api.nvim_win_close(vim.g.yazi_backdrop.winid, true)
            end
            if vim.api.nvim_buf_is_valid(vim.g.yazi_backdrop.bufnr) then
              vim.api.nvim_buf_delete(vim.g.yazi_backdrop.bufnr, { force = true })
            end
            vim.g.yazi_backdrop = nil
          end
        end,
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

      vim.api.nvim_set_hl(0, "YaziFloat", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "YaziBufferHovered", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "YaziBufferHoveredInSameDirectory", { link = "NormalFloat" })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}

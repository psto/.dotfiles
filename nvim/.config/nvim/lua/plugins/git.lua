return {
  -- Diffview
  {
    "sindrets/diffview.nvim",
    event = "BufReadPre",
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim", -- Async signs!
    event = "BufReadPre",
    config = function()
      local icons = require("util.icons")
      require("gitsigns").setup({
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end
          map("n", "[g", gs.next_hunk, "Next Hunk")
          map("n", "]g", gs.prev_hunk, "Prev Hunk")
        end,
        signs     = {
          add = { text = icons.ui.BoldLineLeft },
          change = { text = icons.ui.BoldLineLeft },
          delete = { text = icons.ui.Triangle },
          topdelete = { text = icons.ui.Triangle },
          changedelete = { text = icons.ui.BoldLineLeft },
        },
        numhl     = true, -- Toggle with `:Gitsigns toggle_numhl`
      })
    end
  },

  -- Git Worktree
  {
    "ThePrimeagen/git-worktree.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("git-worktree").setup()
    end
  },

}

return {
  -- Debugging
  { "PatschD/zippy.nvim", event = "BufReadPre" },

  -- Diagnostics
  { "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- References
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
          pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
        end,
      })
    end,
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- LSP
  -- {
  --   "glepnir/lspsaga.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require("lspsaga").setup({})
  --   end,
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } }
  -- },

  -- REST client
  { "NTBBloodbath/rest.nvim", dependencies = "nvim-lua/plenary.nvim", event = "BufReadPre" },

  -- Statusline
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig", event = "BufReadPre" },
}

return {
  -- Debugging
  { "PatschD/zippy.nvim", event = "BufReadPre" },
  { 'michaelb/sniprun', build = 'bash ./install.sh', event = "BufReadPre" },

  -- Diagnostics
  { "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
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
  -- {
  --   "folke/noice.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   }
  -- },
}
